#include <linux/bpf.h>

// datarec stores statistics
#include "../common_user.h"
#include <bpf/bpf_helpers.h>
#include <sys/types.h>

// Keep stats per xdp_action (enum)
struct {
  // Specify map type as an array
  __uint(type, BPF_MAP_TYPE_ARRAY);

  // Type of keys in map
  __type(key, __u32);

  // Type of the values in the map
  __type(value, struct datarec);

  // Maximum extries in the map
  __uint(max_entries, XDP_ACTION_MAX);
} xdp_stats_map SEC(".maps");

/*
  Macro lock_xadd, to perform an atomic addition operation using
  the built-in function __sync_fetch_and_add in llvm
  - Safely increment counters in multi-threaded environment
 */
#ifndef lock_xadd
#define lock_xadd(ptr, val) ((void)__sync_fetch_and_add(ptr, val))
#endif /* ifndef lock_xadd */

// xdp entry point
SEC("xdp")
int xdp_stats1_func(
    struct xdp_md *ctx) { // exec for each pkt (xdp_md: pkt metadata)
  struct datarec *rec;

  __u32 key = XDP_PASS; // 2

  // Lookup in kernel BPF-size
  // return pointer to actual data record
  rec = bpf_map_lookup_elem(&xdp_stats_map, &key);
  if (!rec)
    return XDP_ABORTED;

  // Increment rx_packets counter atomically
  lock_xadd(&rec->rx_packets, 1);

  return XDP_PASS;
}
