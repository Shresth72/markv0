#include <linux/bpf.h>
#include <linux/icmpv6.h>
#include <linux/if_ether.h>
#include <linux/in.h>

#include <bpf/bpf_endian.h>
#include <bpf/bpf_helpers.h>

#include "../../common_user.h"
#include "../../parsers.h"
#include "../../swap.h"

#include "../../common.h"

#ifndef memcpy
#define memcpy(dest, src, n) __builtin_memcpy((dest), (src), (n))
#endif /* memcpy */

struct {
  __uint(type, BPF_MAP_TYPE_DEVMAP);
  __type(key, int);
  __type(value, int);
  __uint(max_entries, 256);
  __uint(pinning, LIBBPF_PIN_BY_NAME);
} tx_port SEC(".maps"); // transmit port

struct {
  __uint(type, BPF_MAP_TYPE_HASH);
  __type(key, unsigned char[ETH_ALEN]);
  __type(value, unsigned char[ETH_ALEN]);
  __uint(max_entries, 1);
  __uint(pinning, LIBBPF_PIN_BY_NAME);
} redirect_params SEC(".maps");

SEC("xdp")
int xdp_redirect_func(struct xdp_md *ctx) {
  void *data_end = (void *)(long)ctx->data_end;
  void *data = (void *)(long)ctx->data;

  struct hdr_cursor nh;
  struct ethhdr *eth;

  int eth_type;
  int action = XDP_PASS;

  nh.pos = data;

  // TODO:
  // unsigned char dst[ETH_ALEN] = {};
  // unsigned ifindex = 0;

  eth_type = parse_ethhdr(&nh, data_end, &eth);
  if (eth_type < 0) {
    action = XDP_ABORTED;
    goto out;
  }

  // TODO: Set a proper destination address and call bpf_redirect()
  // with proper parameters, axtion

out:
  return xdp_stats_record_action(ctx, action);
}
