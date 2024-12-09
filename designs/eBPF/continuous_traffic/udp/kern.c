/*
 * UDP and Inter Packet Arrival Time based
 *
 * Parse the Ethernet payload to check for the IP and UDP protocol headers.
 * Use the UDP-specific traffic to adjust queue lengths dynamically.
 *
 * Record the timestamp of each packet.
 * Calculate the time difference (delta_time) between consecutive packets.
 * Use IPAT trends to detect bursty traffic
 *
 */

#include <linux/bpf.h>
#include <linux/if_ether.h>
#include <linux/in.h>
#include <linux/ip.h>
#include <linux/udp.h>

#include <bpf/bpf_endian.h>
#include <bpf/bpf_helpers.h>

#ifndef XDP_ACTION_MAX
#define XDP_ACTION_MAX (XDP_REDIRECT + 1)
#endif // !XDP_ACTION_MAX

#define SCALE_FACTOR 1000000
#define W_SCALED 2000 // w = 0.002 -> scaled to 2000

#define RED_MIN_THRESH 1000 // Minimum threshold for queue length
#define RED_MAX_THRESH 5000 // Maximum threshold for queue length
#define DROP_PROB_MAX 100   // Maximum drop probability

#define BURST_RESET_QUEUE_LEN 3000 // Queue length when burst is detected

struct datarec {
  __u64 rx_packets;
  __u64 rx_bytes;
};

struct telrec {
  __u64 timestamp;
  __u64 processing_time;
};

struct {
  __uint(type, BPF_MAP_TYPE_ARRAY);
  __type(key, __u32);
  __type(value, struct datarec);
  __uint(max_entries, XDP_ACTION_MAX);
} xdp_stats_map SEC(".maps");

struct {
  __uint(type, BPF_MAP_TYPE_ARRAY);
  __type(key, __u32);
  __type(value, __u64); // Store average queue length
  __uint(max_entries, 1);
} queue_avg_map SEC(".maps");

struct {
  __uint(type, BPF_MAP_TYPE_ARRAY);
  __type(key, __u32);
  __type(value, __u64); // Store last packet timestamp
  __uint(max_entries, 1);
} ipat_map SEC(".maps");

static __always_inline __u64 calculate_avg_queue_len(__u64 prev_avg,
                                                     __u64 curr_queue_len) {
  __u64 weighted_prev_avg = (SCALE_FACTOR - W_SCALED) * prev_avg;
  __u64 weighted_curr_len = W_SCALED * curr_queue_len;
  return (weighted_prev_avg + weighted_curr_len) / SCALE_FACTOR;
}

static __always_inline void handle_burst_detection(__u64 rps, __u64 ipat) {
  __u32 key = 0;
  __u64 *queue_len = bpf_map_lookup_elem(&queue_avg_map, &key);
  if (!queue_len)
    return;

  // Use RPS and IPAT to detect bursts
  if (rps > 200 || ipat < 10000) { // Example thresholds for burst detection
    *queue_len = BURST_RESET_QUEUE_LEN;
  }
}

SEC("xdp_redirect_map")
int xdp_redirect_map_func(struct xdp_md *ctx) {
  __u64 start = bpf_ktime_get_ns();

  void *data_end = (void *)(long)ctx->data_end;
  void *data = (void *)(long)ctx->data;

  struct ethhdr *eth;
  struct iphdr *ip;
  struct udphdr *udp;

  __u32 action = XDP_PASS;
  __u64 queue_len = 50;
  __u32 key = 0;

  // Parse Ethernet header
  if (data + sizeof(struct ethhdr) > data_end)
    return XDP_DROP;
  eth = data;

  // Parse IP header
  ip = data + sizeof(struct ethhdr);
  if ((void *)(ip + 1) > data_end || ip->protocol != IPPROTO_UDP)
    return XDP_PASS; // Non-UDP traffic

  // Parse UDP header
  udp = (void *)ip + (ip->ihl * 4);
  if ((void *)(udp + 1) > data_end)
    return XDP_DROP;

  // Record Inter-Packet Arrival Time (IPAT)
  __u64 *last_timestamp = bpf_map_lookup_elem(&ipat_map, &key);
  __u64 current_time = bpf_ktime_get_ns();
  __u64 ipat = 0;

  if (last_timestamp) {
    ipat = current_time - *last_timestamp;
    bpf_map_update_elem(&ipat_map, &key, &current_time, BPF_ANY);
  } else {
    bpf_map_update_elem(&ipat_map, &key, &current_time, BPF_ANY);
  }

  // Calculate average queue length
  __u64 *prev_avg = bpf_map_lookup_elem(&queue_avg_map, &key);
  if (!prev_avg) {
    action = XDP_DROP;
    goto out;
  }

  __u64 new_avg = calculate_avg_queue_len(*prev_avg, queue_len);
  bpf_map_update_elem(&queue_avg_map, &key, &new_avg, BPF_ANY);

  // Use RPS and IPAT for burst detection
  struct datarec *stats = bpf_map_lookup_elem(&xdp_stats_map, &action);
  if (!stats) {
    action = XDP_DROP;
    goto out;
  }
  __u64 rps = stats->rx_packets * 1000000000 / (current_time - start);
  handle_burst_detection(rps, ipat);

  if (new_avg >= RED_MAX_THRESH) {
    action = XDP_DROP;
    goto out;
  } else if (new_avg <= RED_MIN_THRESH) {
    action = XDP_PASS;
  } else {
    __u64 drop_prob = (new_avg - RED_MIN_THRESH) * DROP_PROB_MAX /
                      (RED_MAX_THRESH - RED_MIN_THRESH);
    if (bpf_get_prandom_u32() % 100 < drop_prob) {
      action = XDP_DROP;
      goto out;
    }
  }

out:
  return action;
}

char _license[] SEC("license") = "GPL";
