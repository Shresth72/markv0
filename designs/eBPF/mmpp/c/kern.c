#include <linux/bpf.h>
#include <linux/if_ether.h>
#include <linux/in.h>

#include <bpf/bpf_endian.h>
#include <bpf/bpf_helpers.h>

#ifndef XDP_ACTION_MAX
#define XDP_ACTION_MAX (XDP_REDIRECT + 1)
#endif // !XDP_ACTION_MAX

#define SCALE 10000            // Scaling factor for fixed-point arithmetic
#define ALPHA 8000             // Represent ALPHA in fixed-point
#define WINDOW_SIZE 1000000000 // nanoseconds
#define MAX_QUEUE_SIZE 5000
#define MAX_SOURCES 4

// map returned to the user program
struct packet_stats {
  __u64 rx_packets;
  __u64 service_rate;
  __u64 queue_size; // number of packets in shaper
};

struct shaper_stats {
  __u64 window_start; // window T
  __u64 n_shaper;     // number of packets in shaper
  __u64 n_arrivals;   // number of packets received during the current T
  __u64 n_average;    // average number of packets received computed at end of T
};
// n(ave) = alpha * n(ave) + (1 - alpha) * n(arr)
// service rate = n(ave) / T

struct {
  __uint(type, BPF_MAP_TYPE_ARRAY);
  __type(key, __u32);
  __type(value, struct packet_stats);
  __uint(max_entries, 1);
} xdp_stats_map SEC(".maps");

struct {
  __uint(type, BPF_MAP_TYPE_ARRAY);
  __type(key, __u32);
  __type(value, struct shaper_stats);
  __uint(max_entries, 1);
} shaper_stats_map SEC(".maps");

struct {
  __uint(type, BPF_MAP_TYPE_ARRAY);
  __type(key, __u32);
  __type(value, __u32);
  __uint(max_entries, 1);
} current_state SEC(".maps");

static __always_inline __u32 xdp_stats_record_action(struct xdp_md *ctx,
                                                     __u32 action,
                                                     __u64 service_rate,
                                                     __u64 queue_size) {
  __u32 key = 0;
  struct packet_stats *xdp_stats_ptr =
      bpf_map_lookup_elem(&xdp_stats_map, &key);

  if (xdp_stats_ptr) {
    xdp_stats_ptr->rx_packets++;
    xdp_stats_ptr->service_rate = service_rate;
    xdp_stats_ptr->queue_size = queue_size;
  }

  return action;
}

SEC("xdp")
int xdp_mmpp_shaper(struct xdp_md *ctx) {
  __u64 now = bpf_ktime_get_ns();
  __u32 key = 0;
  __u32 action = XDP_PASS;

  struct packet_stats *xdp_stats_ptr =
      bpf_map_lookup_elem(&xdp_stats_map, &key);
  struct shaper_stats *shaper_stats_ptr =
      bpf_map_lookup_elem(&shaper_stats_map, &key);

  // Initialize variables to default values to avoid uninitialized use
  __u64 service_rate = 0;
  __u64 queue_size = 0;

  if (!xdp_stats_ptr || !shaper_stats_ptr) {
    action = XDP_ABORTED;
    goto out;
  }

  if (now - shaper_stats_ptr->window_start >= WINDOW_SIZE) {
    // Update n_average using fixed-point arithmetic
    shaper_stats_ptr->n_average =
        (ALPHA * shaper_stats_ptr->n_average / SCALE) +
        ((SCALE - ALPHA) * shaper_stats_ptr->n_arrivals / SCALE);
    shaper_stats_ptr->window_start = now;
    shaper_stats_ptr->n_arrivals = 0;
  }

  shaper_stats_ptr->n_arrivals++;

  // Calculate service rate using fixed-point
  service_rate =
      (shaper_stats_ptr->n_average * SCALE) /
      (now - shaper_stats_ptr->window_start + 1); // Fixed-point division
  queue_size = xdp_stats_ptr->queue_size;

  if (service_rate > shaper_stats_ptr->n_average) {
    if (queue_size >= MAX_QUEUE_SIZE) {
      action = XDP_DROP;
    } else {
      queue_size++;
    }
  } else if (queue_size > 0) {
    queue_size--;
  }

out:
  return xdp_stats_record_action(ctx, action, service_rate, queue_size);
}

char _license[] SEC("license") = "GPL";
