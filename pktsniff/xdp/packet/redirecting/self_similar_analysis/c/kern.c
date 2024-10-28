#include <linux/bpf.h>
#include <linux/if_ether.h>
#include <linux/in.h>

#include <bpf/bpf_endian.h>
#include <bpf/bpf_helpers.h>

#define MAX_SOURCES 4
#define WINDOW_SIZE 1000000000
#define MAX_QUEUE_SIZE 300
#define SCALE_FACTOR 1000000

struct mmpp_source {
  __u64 lambda1;
  __u64 lambda2;
  __u64 c1;
  __u64 c2;
  __u64 current_state;
  __u64 last_transition;
};

struct datarec {
  __u64 rx_packets;
  __u64 rx_bytes;
  __u64 tx_packets;
  __u64 tx_bytes;
  __u64 dropped_packets;
  __u64 lambda;
  __u64 current_state;
  __u64 last_update;
};

struct {
  __uint(type, BPF_MAP_TYPE_ARRAY);
  __type(key, __u32);
  __type(value, struct datarec);
  __uint(max_entries, MAX_SOURCES);
} xdp_stats_map SEC(".maps");

struct {
  __uint(type, BPF_MAP_TYPE_ARRAY);
  __type(key, __u32);
  __type(value, struct mmpp_source);
  __uint(max_entries, MAX_SOURCES);
} mmpp_sources SEC(".maps");

struct {
  __uint(type, BPF_MAP_TYPE_ARRAY);
  __type(key, __u32);
  __type(value, __u64);
  __uint(max_entries, 1);
} window_start SEC(".maps");

struct {
  __uint(type, BPF_MAP_TYPE_ARRAY);
  __type(key, __u32);
  __type(value, __u64);
  __uint(max_entries, 1);
} packet_count SEC(".maps");

struct {
  __uint(type, BPF_MAP_TYPE_ARRAY);
  __type(key, __u32);
  __type(value, __u64);
  __uint(max_entries, 1);
} average_count SEC(".maps");

struct {
  __uint(type, BPF_MAP_TYPE_ARRAY);
  __type(key, __u32);
  __type(value, __u64);
  __uint(max_entries, 1);
} queue_size SEC(".maps");

// Hurst parameter H for self-similarity (between 0.5 and 1)
#define H 0.75

static __always_inline __u32 xdp_stats_record_action(
    struct xdp_md *ctx, __u32 action, __u64 start, struct mmpp_source *source) {
  if (action >= MAX_SOURCES)
    return XDP_ABORTED;

  struct datarec *rec = bpf_map_lookup_elem(&xdp_stats_map, &action);
  if (!rec)
    return XDP_ABORTED;

  rec->rx_packets++;
  rec->rx_bytes += (ctx->data_end - ctx->data);
  rec->lambda =
      (source->current_state == 1) ? source->lambda1 : source->lambda2;
  rec->current_state = source->current_state;
  rec->last_update = start;

  if (action == XDP_DROP) {
    rec->dropped_packets++;
  } else {
    rec->tx_packets++;
    rec->tx_bytes += (ctx->data_end - ctx->data);
  }

  return action;
}

SEC("xdp")
int xdp_traffic_shaper(struct xdp_md *ctx) {
  __u64 start = bpf_ktime_get_ns();
  __u32 action = XDP_PASS;
  __u32 key = 0;

  // Simplify by checking for map values early
  __u64 *window_start_ptr = bpf_map_lookup_elem(&window_start, &key);
  __u64 *packet_count_ptr = bpf_map_lookup_elem(&packet_count, &key);
  __u64 *average_count_ptr = bpf_map_lookup_elem(&average_count, &key);
  __u64 *queue_size_ptr = bpf_map_lookup_elem(&queue_size, &key);
  struct mmpp_source *source = bpf_map_lookup_elem(&mmpp_sources, &key);

  if (!window_start_ptr || !packet_count_ptr || !average_count_ptr ||
      !queue_size_ptr || !source)
    return XDP_ABORTED;

  // Move calculations into inline functions if possible
  __u64 now = bpf_ktime_get_ns();
  if (now - *window_start_ptr >= WINDOW_SIZE) {
    *window_start_ptr = now;
    *average_count_ptr =
        (*average_count_ptr * (SCALE_FACTOR - 1) + *packet_count_ptr) /
        SCALE_FACTOR;
    *packet_count_ptr = 0;
  }

  // Simplified state transition
  __u64 transition_prob = bpf_get_prandom_u32();
  if ((source->current_state == 1 && transition_prob < source->c2) ||
      (source->current_state == 2 && transition_prob < source->c1)) {
    source->current_state = 3 - source->current_state;
  }

  // Aggregate traffic intensity (consider moving outside the XDP program)
  __u64 lambda = source->current_state == 1 ? source->lambda1 : source->lambda2;

  (*packet_count_ptr)++;
  if (*queue_size_ptr > MAX_QUEUE_SIZE || lambda < *average_count_ptr) {
    action = XDP_DROP;
  } else {
    (*queue_size_ptr)++;
  }

  return xdp_stats_record_action(ctx, action, start, source);
}

char _license[] SEC("license") = "GPL";
