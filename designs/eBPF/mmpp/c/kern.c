#include <linux/bpf.h>
#include <linux/if_ether.h>
#include <linux/in.h>

#include <bpf/bpf_endian.h>
#include <bpf/bpf_helpers.h>

#ifndef XDP_ACTION_MAX
#define XDP_ACTION_MAX (XDP_REDIRECT + 1)
#endif // !XDP_ACTION_MAX

#define WINDOW_SIZE 1000000000 // nanoseconds
#define ALPHA 0.8
#define MAX_QUEUE_SIZE 5000
#define MAX_SOURCES 4

struct mmpp_source {
  __u64 lambda1; // source intensity
  __u64 lambda2;
  __u64 c1; // transition intensity
  __u64 c2;
};

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
// Service Rate = n(ave) / T

struct {
  __uint(type, BPF_MAP_TYPE_ARRAY);
  __type(key, __u32);
  __type(value, struct mmpp_source);
  __uint(max_entries, MAX_SOURCES);
} mmpp_sources SEC(".maps");

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

  /*
  __u32 *curr_state = bpf_map_lookup_elem(&current_state, &key);
  if (!curr_state) {
    action = XDP_ABORTED;
    goto out;
  }
  struct mmpp_source *mmpp_sources_ptr =
      bpf_map_lookup_elem(&mmpp_sources, curr_state);
  */

  struct packet_stats *xdp_stats_ptr =
      bpf_map_lookup_elem(&xdp_stats_map, &key);
  struct shaper_stats *shaper_stats_ptr =
      bpf_map_lookup_elem(&shaper_stats_map, &key);

  if (!xdp_stats_ptr || !shaper_stats_ptr) {
    action = XDP_ABORTED;
    goto out;
  }

  if (now - shaper_stats_ptr->window_start >= WINDOW_SIZE) {
    shaper_stats_ptr->n_average = (ALPHA * shaper_stats_ptr->n_average +
                                   (1 - ALPHA) * shaper_stats_ptr->n_arrivals);
    shaper_stats_ptr->window_start = now;
    shaper_stats_ptr->n_arrivals = 0;
  }

  shaper_stats_ptr->n_arrivals++;

  __u64 service_rate =
      shaper_stats_ptr->n_average /
      (now - shaper_stats_ptr->window_start + 1); // Avoid division by zero
  __u64 queue_size = xdp_stats_ptr->queue_size;

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
