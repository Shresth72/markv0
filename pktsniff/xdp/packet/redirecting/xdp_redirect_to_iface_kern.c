#include <linux/bpf.h>
#include <linux/icmpv6.h>
#include <linux/if_ether.h>
#include <linux/in.h>

#include <bpf/bpf_endian.h>
#include <bpf/bpf_helpers.h>

#include "../../common_user.h"
#include "../../parsers.h"

#include "../../common.h"

#ifndef memcpy
#define memcpy(dest, src, n) __builtin_memcpy((dest), (src), (n))
#endif /* memcpy */

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

SEC("xdp")
int xdp_get_iface_index(struct __sk_buff *skb) {
  __u32 key = 0;
  __u32 *tx_port_index = bpf_map_lookup_elem(&tx_port, &key);
  if (!tx_port_index) {
    return XDP_DROP;
  }
  return bpf_redirect_map(&tx_port, *tx_port_index, 0);
}

SEC("xdp_redirect_map")
int xdp_redirect_map_func(struct xdp_md *ctx) {
  void *data_end = (void *)(long)ctx->data_end;
  void *data = (void *)(long)ctx->data;

  struct hdr_cursor nh;
  struct ethhdr *eth;
  __u32 eth_type;
  __u32 action = XDP_PASS;

  unsigned char *dst;
  __u32 *iface_index;

  nh.pos = data;
  eth_type = parse_ethhdr(&nh, data_end, &eth);
  if (eth_type < -1)
    goto out;

  dst = bpf_map_lookup_elem(&redirect_params, eth->h_source);
  if (!dst)
    goto out;

  memcpy(eth->h_dest, dst, ETH_ALEN);

  // Use appropriate key (TODO: test this)
  iface_index = bpf_map_lookup_elem(&tx_port, 0);
  if (!iface_index)
    goto out;

  // tx_port should populated by the user_space
  action = bpf_redirect_map(&tx_port, *iface_index, 0);

out:
  return xdp_stats_record_action(ctx, action);
}
