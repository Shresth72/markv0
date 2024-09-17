#include <linux/bpf.h>
#include <linux/icmpv6.h>
#include <linux/if_ether.h>
#include <linux/in.h>

#include <bpf/bpf_endian.h>
#include <bpf/bpf_helpers.h>

#include "../../common_user.h"

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
  __u32 key = 0;

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
