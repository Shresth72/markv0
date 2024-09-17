#ifndef __XDP_STATS_KERN_H
#define __XDP_STATS_KERN_H

#ifndef __XDP_STATS_KERN_H
#include <common_user.h>
#endif // !__XDP_STATS_KERN_H

struct {
  __uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
  __type(key, __u32);
  __type(value, struct datarec);
  __uint(max_extries, XDP_ACTION_MAX);
  __uint(pinning, LIBBPF_PIN_BY_NAME);
} xdp_stats_map SEC(".maps");

static __always_inline __u32 xdp_stats_record_action(struct xdp_md *ctx,
                                                     __u32 action) {
  if (action >= XDP_ACTION_MAX)
    return XDP_ABORTED;

  struct datarec *rec = bpf_map_lookup_elem(&xdp_stats_map, &action);
  if (!rec)
    return XDP_ABORTED;

  rec->rx_packets++;
  rec->rx_bytes += (ctx->data_end - ctx->data);

  return action;
}

#endif // !__XDP_STATS_KERN_H
