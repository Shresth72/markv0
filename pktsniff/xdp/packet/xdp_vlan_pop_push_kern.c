#include <linux/bpf.h>

#include <bpf/bpf_endian.h>
#include <bpf/bpf_helpers.h>
#include <sys/cdefs.h>

#include "../parsers.h"

// Pops the outermost VLAN tag off the packet
// Returns the popped VLAN_ID on success
static __always_inline int vlan_tag_pop(struct xdp_md *ctx,
                                        struct ethhdr *eth) {
  void *data_end = (void *)(long)ctx->data_end;
  struct ethhdr eth_cpy;
  struct vlan_hdr *vlh;
  __be16 h_proto;
  int vlan_id;

  if (!proto_is_vlan(eth->h_proto))
    return -1;

  if ((void *)(eth + 1) + 1 > data_end)
    return -1;

  vlan_id = bpf_ntohs(vlh->h_vlan_TCI);
  h_proto = vlh->h_vlan_encapsulated_proto;

  // Make a copy of the outer Ethernet header before cutting it off
  __builtin_memcpy(&eth_cpy, eth, sizeof(eth_cpy));

  // Adjust head pointer
  if (bpf_xdp_adjust_head(ctx, (int)sizeof(*vlh)))
    return -1;

  eth = (void *)(long)ctx->data;
  data_end = (void *)(long)ctx->data_end;
  if ((void *)eth + 1 > data_end)
    return -1;

  __builtin_memcpy(eth, &eth_cpy, sizeof(*eth));
  eth->h_proto = h_proto;

  return vlan_id;
}

static __always_inline int vlan_tag_push(struct xdp_md *ctx, struct ethhdr *eth,
                                         int vlan_id) {
  void *data_end = (void *)(long)ctx->data_end;
  struct ethhdr eth_cpy;
  struct vlan_hdr *vlh;

  __builtin_memcpy(&eth_cpy, eth, sizeof(eth_cpy));

  if (bpf_xdp_adjust_head(ctx, 0 - (int)sizeof(*vlh)))
    return -1;

  data_end = (void *)(long)ctx->data_end;
  eth = (void *)(long)ctx->data;

  if ((void *)eth + 1 > data_end)
    return -1;

  __builtin_memcpy(eth, &eth_cpy, sizeof(*eth));

  vlh = (void *)(eth + 1);
  if ((void *)vlh + 1 > data_end)
    return -1;

  vlh->h_vlan_TCI = bpf_ntohs(vlan_id);
  vlh->h_vlan_encapsulated_proto = eth->h_proto;

  eth->h_proto = bpf_htons(ETH_P_8021Q);
  return 0;
}

// Either pops or pushes a VLAN tag on the Ethernet header
// depending on whether the packer already has a VLAN tag.
SEC("xdp")
int xdp_vlan_swap_func(struct xdp_md *ctx) {
  void *data_end = (void *)(long)ctx->data_end;
  void *data = (void *)(long)ctx->data;

  struct hdr_cursor nh;
  int nh_type;
  nh.pos = data;

  struct ethhdr *eth;
  nh_type = parse_ethhdr(&nh, data_end, &eth);
  if (nh_type < 0)
    return XDP_PASS;

  if (proto_is_vlan(eth->h_proto))
    vlan_tag_pop(ctx, eth);
  else
    vlan_tag_push(ctx, eth, 1);

  return XDP_PASS;
}
