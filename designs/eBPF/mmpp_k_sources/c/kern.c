#include <linux/bpf.h>
#include <linux/if_ether.h>
#include <linux/in.h>

#include <bpf/bpf_endian.h>
#include <bpf/bpf_helpers.h>

#ifndef XDP_ACTION_MAX
#define XDP_ACTION_MAX (XDP_REDIRECT + 1)
#endif

#define SCALE 1000000000 // 1 second in nanoseconds for better precision
#define ALPHA 8000
#define MIN_WINDOW_DIFF 10000000 // 10 milliseconds in nanoseconds
#define WINDOW_SIZE 8000000000   // 1 second in nanoseconds
#define MAX_QUEUE_SIZE 300
#define MAX_SOURCES 5

#define MIN_AVERAGE 10 // Minimum value for n_average to avoid zero service rate

struct xdp_stats {
  __u64 rx_packets;
  __u64 service_rate;
  __u64 queue_size;
};

struct shaper_stats {
  __u64 window_start;
  __u64 n_arrivals;
  __u64 n_average;
};

struct {
  __uint(type, BPF_MAP_TYPE_ARRAY);
  __type(key, __u32);
  __type(value, struct xdp_stats);
  __uint(max_entries, MAX_SOURCES);
} xdp_stats_map SEC(".maps");

struct {
  __uint(type, BPF_MAP_TYPE_ARRAY);
  __type(key, __u32);
  __type(value, struct shaper_stats);
  __uint(max_entries, MAX_SOURCES);
} shaper_stats_map SEC(".maps");

static __always_inline void
xdp_stats_record_action(struct xdp_md *ctx, __u32 action, __u32 src_index,
                        __u64 service_rate, __u64 queue_size) {
  struct xdp_stats *xdp_stats_ptr =
      bpf_map_lookup_elem(&xdp_stats_map, &src_index);

  if (xdp_stats_ptr) {
    xdp_stats_ptr->rx_packets++;
    xdp_stats_ptr->service_rate = service_rate;
    xdp_stats_ptr->queue_size = queue_size;
  }
}

static __always_inline __u64
calculate_service_rate(struct shaper_stats *shaper_stats_ptr, __u64 now) {
  __u64 time_diff = now - shaper_stats_ptr->window_start;

  if (time_diff < MIN_WINDOW_DIFF) {
    time_diff = MIN_WINDOW_DIFF;
  }

  if (shaper_stats_ptr->n_average < MIN_AVERAGE) {
    shaper_stats_ptr->n_average = MIN_AVERAGE;
  }

  // Calculate service rate with adjusted scaling factor
  __u64 service_rate = (shaper_stats_ptr->n_average * SCALE) / time_diff;
  return service_rate;
}

static __always_inline void
update_shaper_stats(struct shaper_stats *shaper_stats_ptr, __u64 now) {
  if (shaper_stats_ptr->n_average < MIN_AVERAGE) {
    shaper_stats_ptr->n_average = MIN_AVERAGE;
  }

  if (now - shaper_stats_ptr->window_start >= WINDOW_SIZE) {
    shaper_stats_ptr->n_average =
        (ALPHA * shaper_stats_ptr->n_average +
         (SCALE - ALPHA) * shaper_stats_ptr->n_arrivals) /
        SCALE;
    shaper_stats_ptr->window_start = now;
    shaper_stats_ptr->n_arrivals = 0;
  }

  shaper_stats_ptr->n_arrivals++;
}

static __always_inline void handle_packet(struct xdp_md *ctx, __u32 src_index,
                                          __u64 now) {
  struct shaper_stats *shaper_stats_ptr =
      bpf_map_lookup_elem(&shaper_stats_map, &src_index);
  struct xdp_stats *xdp_stats_ptr =
      bpf_map_lookup_elem(&xdp_stats_map, &src_index);

  if (!xdp_stats_ptr || !shaper_stats_ptr) {
    return;
  }

  update_shaper_stats(shaper_stats_ptr, now);

  __u64 service_rate = calculate_service_rate(shaper_stats_ptr, now);
  __u64 queue_size = xdp_stats_ptr->queue_size;

  if (service_rate >= shaper_stats_ptr->n_average) {
    // Process packet and decrement the queue if it was occupied
    if (queue_size > 0) {
      queue_size--;
    }
  } else {
    // If the service rate is below n_average, try to queue the packet if not
    // full
    if (queue_size < MAX_QUEUE_SIZE) {
      queue_size++;
    }
  }

  xdp_stats_ptr->queue_size = queue_size;
  xdp_stats_ptr->service_rate = service_rate;

  // Record packet processing action (pass/drop) based on service rate condition
  __u32 action = (queue_size < MAX_QUEUE_SIZE ||
                  service_rate >= shaper_stats_ptr->n_average)
                     ? XDP_PASS
                     : XDP_DROP;
  xdp_stats_record_action(ctx, action, src_index, service_rate, queue_size);
}

SEC("xdp")
int xdp_mmpp_shaper(struct xdp_md *ctx) {
  __u64 now = bpf_ktime_get_ns();

  for (__u32 src_index = 0; src_index < MAX_SOURCES; src_index++) {
    handle_packet(ctx, src_index, now);
  }

  return XDP_PASS;
}

char _license[] SEC("license") = "GPL";
