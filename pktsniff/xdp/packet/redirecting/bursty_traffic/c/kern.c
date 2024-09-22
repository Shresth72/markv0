#include <linux/bpf.h>
#include <linux/if_ether.h>
#include <linux/in.h>

#include <bpf/bpf_endian.h>
#include <bpf/bpf_helpers.h>

#include "../../../../common_user.h"

struct datarec {
  __u64 rx_packets;
  __u64 rx_bytes;
};

struct telrec {
  __u64 timestamp;
  __u64 processing_time;
};

#ifndef XDP_ACTION_MAX
#define XDP_ACTION_MAX (XDP_REDIRECT + 1)
#endif // !XDP_ACTION_MAX

#define SCALE_FACTOR 1000000
#define W_SCALED 2000 // w = 0.002 -> scaled to 2000

#define RED_MIN_THRESH 1000 // Minimum threshold for queue length
#define RED_MAX_THRESH 5000 // Maximum threshold for queue length
#define RED_WEIGHT 0.002    // Weight for average queue length
#define DROP_PROB_MAX 100

struct {
  __uint(type, BPF_MAP_TYPE_ARRAY);
  __type(key, __u32);
  __type(value, struct datarec);
  __uint(max_entries, XDP_ACTION_MAX);
} xdp_stats_map SEC(".maps");

struct {
  __uint(type, BPF_MAP_TYPE_ARRAY);
  __type(key, __u32);
  __type(value, struct telrec);
  __uint(max_entries, XDP_ACTION_MAX);
} telemetry_stats_map SEC(".maps");

struct {
  __uint(type, BPF_MAP_TYPE_DEVMAP);
  __type(key, __u32);
  __type(value, __u32);
  __uint(max_entries, 256);
} tx_port SEC(".maps");

struct {
  __uint(type, BPF_MAP_TYPE_HASH);
  __type(key, unsigned char[ETH_ALEN]);
  __type(value, unsigned char[ETH_ALEN]);
  __uint(max_entries, 1);
} redirect_params SEC(".maps");

struct {
  __uint(type, BPF_MAP_TYPE_ARRAY);
  __type(key, __u32);
  __type(value, __u64); // Store average queue length as u64
  __uint(max_entries, 1);
} queue_avg_map SEC(".maps");

// Function to calculate the weighted average queue length in fixed-point
// arithmetic
static __always_inline __u64 calculate_avg_queue_len(__u64 prev_avg,
                                                     __u64 curr_queue_len) {
  // avg_scaled = ((SCALE_FACTOR - W_SCALED) * prev_avg + W_SCALED *
  // curr_queue_len) / SCALE_FACTOR;
  __u64 weighted_prev_avg = (SCALE_FACTOR - W_SCALED) * prev_avg;
  __u64 weighted_curr_len = W_SCALED * curr_queue_len;
  return (weighted_prev_avg + weighted_curr_len) / SCALE_FACTOR;
}

static __always_inline __u32 xdp_stats_record_action(struct xdp_md *ctx,
                                                     __u32 action,
                                                     __u64 start) {
  if (action >= XDP_ACTION_MAX)
    return XDP_ABORTED;

  struct datarec *rec = bpf_map_lookup_elem(&xdp_stats_map, &action);
  if (!rec)
    return XDP_ABORTED;

  // Update statistics
  rec->rx_packets++;
  rec->rx_bytes += (ctx->data_end - ctx->data);

  struct telrec *telemetry = bpf_map_lookup_elem(&telemetry_stats_map, &action);
  if (!telemetry)
    return XDP_ABORTED;

  telemetry->timestamp = bpf_ktime_get_ns();
  telemetry->processing_time = telemetry->timestamp - start;

  return action;
}

SEC("xdp_redirect_map")
int xdp_redirect_map_func(struct xdp_md *ctx) {
  __u64 start = bpf_ktime_get_ns();

  void *data_end = (void *)(long)ctx->data_end;
  void *data = (void *)(long)ctx->data;

  struct ethhdr *eth;
  __u32 action = XDP_PASS;
  __u64 queue_len = 50;
  __u32 key = 0;

  __u64 *prev_avg = bpf_map_lookup_elem(&queue_avg_map, &key);
  if (!prev_avg) {
    action = XDP_DROP;
    goto out;
  }

  __u64 new_avg = calculate_avg_queue_len(*prev_avg, queue_len);
  bpf_map_update_elem(&queue_avg_map, &key, &new_avg, BPF_ANY);

  if (new_avg >= RED_MAX_THRESH) {
    action = XDP_DROP; // Drop the packet if avg >= max threshold
    goto out;
  } else if (new_avg <= RED_MIN_THRESH) {
    action = XDP_PASS; // Pass the packet if avg <= min threshold
  } else {
    // Calculate drop probability (for avg between min and max)
    __u64 drop_prob = (new_avg - RED_MIN_THRESH) * DROP_PROB_MAX /
                      (RED_MAX_THRESH - RED_MIN_THRESH);

    // Randomly drop the packet based on the calculated probability
    if (bpf_get_prandom_u32() % 100 < drop_prob) {
      action = XDP_DROP;
      goto out;
    }
  }

  // Boundary check
  if (data + sizeof(struct ethhdr) > data_end)
    return XDP_DROP;

  eth = data;

  unsigned char *dst = bpf_map_lookup_elem(&redirect_params, eth->h_source);
  if (!dst)
    goto out;

  // Copy destination MAC
  __builtin_memcpy(eth->h_dest, dst, ETH_ALEN);

  __u32 *iface_index = bpf_map_lookup_elem(&tx_port, &key);
  if (!iface_index)
    goto out;

  action = bpf_redirect_map(&tx_port, *iface_index, 0);

out:
  return xdp_stats_record_action(ctx, action, start);
}

char _license[] SEC("license") = "GPL";
