#include <linux/bpf.h>
#include <linux/if_ether.h>
#include <linux/in.h>
#include <linux/ip.h>

#include <bpf/bpf_endian.h>
#include <bpf/bpf_helpers.h>

#define TARGET_SERVER_IP bpf_htonl(0xC0A80101)

#ifndef XDP_ACTION_MAX
#define XDP_ACTION_MAX (XDP_REDIRECT + 1)
#endif

// Configuration parameters
#define SCALE_FACTOR 1000000
#define W_SCALED 2000 // w = 0.002 -> scaled to 2000

#define RED_MIN_THRESH 1000 // Minimum threshold for queue length
#define RED_MAX_THRESH 5000 // Maximum threshold for queue length
#define DROP_PROB_MAX 100   // Maximum drop probability

#define BURST_RPS_THRESH 200       // Requests per second threshold
#define BURST_RESET_QUEUE_LEN 3000 // Queue length when burst is detected

// Data structures
struct datarec {
  __u64 rx_packets;
  __u64 rx_bytes;
};

struct telrec {
  __u64 timestamp;
  __u64 processing_time;
};

// Maps definitions
struct {
  __uint(type, BPF_MAP_TYPE_ARRAY);
  __type(key, __u32);
  __type(value, struct datarec);
  __uint(max_entries, XDP_ACTION_MAX);
} xdp_stats_map SEC(".maps");

struct {
  __uint(type, BPF_MAP_TYPE_ARRAY);
  __type(key, __u32);
  __type(value, __u32);
  __uint(max_entries, 1);
} target_ip_map SEC(".maps");

struct {
  __uint(type, BPF_MAP_TYPE_ARRAY);
  __type(key, __u32);
  __type(value, struct telrec);
  __uint(max_entries, XDP_ACTION_MAX);
} telemetry_stats_map SEC(".maps");

struct {
  __uint(type, BPF_MAP_TYPE_ARRAY);
  __type(key, __u32);
  __type(value, __u64); // Store average queue length
  __uint(max_entries, 1);
} queue_avg_map SEC(".maps");

struct {
  __uint(type, BPF_MAP_TYPE_ARRAY);
  __type(key, __u32);
  __type(value, __u64); // Store last timestamp
  __uint(max_entries, XDP_ACTION_MAX);
} last_timestamp_map SEC(".maps");

struct {
  __uint(type, BPF_MAP_TYPE_ARRAY);
  __type(key, __u32);
  __type(value, __u64); // Store request count
  __uint(max_entries, XDP_ACTION_MAX);
} request_count_map SEC(".maps");

// Helper functions
static __always_inline __u64 calculate_avg_queue_len(__u64 prev_avg,
                                                     __u64 curr_queue_len) {
  __u64 weighted_prev_avg = (SCALE_FACTOR - W_SCALED) * prev_avg;
  __u64 weighted_curr_len = W_SCALED * curr_queue_len;
  return (weighted_prev_avg + weighted_curr_len) / SCALE_FACTOR;
}

static __always_inline int handle_burst_detection(__u32 key,
                                                  struct datarec *stats,
                                                  struct telrec *telemetry) {
  __u64 *last_timestamp = bpf_map_lookup_elem(&last_timestamp_map, &key);
  __u64 *request_count = bpf_map_lookup_elem(&request_count_map, &key);

  if (!last_timestamp || !request_count) {
    return 0;
  }

  // Calculate time difference in nanoseconds
  __u64 time_diff = telemetry->timestamp - *last_timestamp;

  // Convert to seconds (nanoseconds to seconds)
  __u64 time_diff_sec = time_diff / 1000000000;

  if (time_diff_sec >= 1) {
    // Calculate current RPS using packet count difference
    __u64 packet_diff = stats->rx_packets - *request_count;
    __u64 current_rps = packet_diff / time_diff_sec;

    // Update last known packet count
    bpf_map_update_elem(&request_count_map, &key, &stats->rx_packets, BPF_ANY);
    // Update last timestamp
    bpf_map_update_elem(&last_timestamp_map, &key, &telemetry->timestamp,
                        BPF_ANY);

    // Check if we're in a burst
    if (current_rps > BURST_RPS_THRESH) {
      __u64 *avg_queue = bpf_map_lookup_elem(&queue_avg_map, &key);
      if (avg_queue) {
        __u64 new_avg = BURST_RESET_QUEUE_LEN;
        bpf_map_update_elem(&queue_avg_map, &key, &new_avg, BPF_ANY);
        return 0;
      }
    }
  }

  return 0;
}

static __always_inline __u32 xdp_stats_record_action(struct xdp_md *ctx,
                                                     __u32 action,
                                                     __u64 start) {
  if (action >= XDP_ACTION_MAX)
    return XDP_ABORTED;

  // Get and update statistics
  struct datarec *rec = bpf_map_lookup_elem(&xdp_stats_map, &action);
  if (!rec)
    return XDP_ABORTED;

  rec->rx_packets++;
  rec->rx_bytes += (ctx->data_end - ctx->data);

  // Get and update telemetry
  struct telrec *telemetry = bpf_map_lookup_elem(&telemetry_stats_map, &action);
  if (!telemetry)
    return XDP_ABORTED;

  telemetry->timestamp = bpf_ktime_get_ns();
  telemetry->processing_time = telemetry->timestamp - start;

  // Initialize timestamp and request count if needed
  __u64 *last_timestamp = bpf_map_lookup_elem(&last_timestamp_map, &action);
  if (!last_timestamp) {
    bpf_map_update_elem(&last_timestamp_map, &action, &telemetry->timestamp,
                        BPF_ANY);
    bpf_map_update_elem(&request_count_map, &action, &rec->rx_packets, BPF_ANY);
  }

  // Handle burst detection using the updated statistics
  handle_burst_detection(action, rec, telemetry);

  return action;
}

// Main XDP program
SEC("xdp_redirect_map")
int xdp_redirect_map_func(struct xdp_md *ctx) {
  __u64 start = bpf_ktime_get_ns();
  void *data_end = (void *)(long)ctx->data_end;
  void *data = (void *)(long)ctx->data;

  struct ethhdr *eth = data;
  struct iphdr *ip;

  if (data + sizeof(struct ethhdr) > data_end)
    return XDP_DROP;

  if (eth->h_proto != bpf_htons(ETH_P_IP))
    return XDP_PASS;

  ip = data + sizeof(struct ethhdr);
  if ((void *)(ip + 1) > data_end)
    return XDP_DROP;

  __u32 action = XDP_PASS;
  __u64 queue_len =
      50; // This should be replaced with actual queue length measurement
  __u32 key = 0;
  __u32 *target_ip = bpf_map_lookup_elem(&target_ip_map, &key);
  if (!target_ip)
    return XDP_DROP;

  if (ip->saddr != *target_ip)
    return XDP_PASS;

  // Get current statistics for burst detection
  struct datarec *rec = bpf_map_lookup_elem(&xdp_stats_map, &key);
  struct telrec *telemetry = bpf_map_lookup_elem(&telemetry_stats_map, &key);
  int is_burst = 0;

  if (rec && telemetry) {
    is_burst = handle_burst_detection(key, rec, telemetry);
  }

  // Adjust queue length if we're in a burst
  if (is_burst) {
    queue_len = BURST_RESET_QUEUE_LEN;
  }

  // Get current average queue length
  __u64 *prev_avg = bpf_map_lookup_elem(&queue_avg_map, &key);
  if (!prev_avg) {
    action = XDP_DROP;
    goto out;
  }

  // Calculate new average queue length
  __u64 new_avg = calculate_avg_queue_len(*prev_avg, queue_len);
  bpf_map_update_elem(&queue_avg_map, &key, &new_avg, BPF_ANY);

  // Apply RED algorithm with consideration for bursts
  if (new_avg >= RED_MAX_THRESH || is_burst) {
    action = XDP_DROP;
    goto out;
  } else if (new_avg <= RED_MIN_THRESH && !is_burst) {
    action = XDP_PASS;
  } else {
    __u64 drop_prob = (new_avg - RED_MIN_THRESH) * DROP_PROB_MAX /
                      (RED_MAX_THRESH - RED_MIN_THRESH);

    if (is_burst) {
      drop_prob = (drop_prob * 3) / 2; // Increase drop probability during burst
    }

    if (bpf_get_prandom_u32() % 100 < drop_prob) {
      action = XDP_DROP;
      goto out;
    }
  }

  // Packet boundary check
  if (data + sizeof(struct ethhdr) > data_end)
    return XDP_DROP;

  eth = data;

out:
  return xdp_stats_record_action(ctx, action, start);
}

char _license[] SEC("license") = "GPL";
