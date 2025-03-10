#include <linux/bpf.h>
#include <linux/icmpv6.h>
#include <linux/if_ether.h>
#include <linux/in.h>

#include <bpf/bpf_endian.h>
#include <bpf/bpf_helpers.h>
#include <linux/in6.h>

#include "../../common_user.h"
#include "../../parsers.h"

#include "../../common.h"

#undef AF_INET
#define AF_INET 2
#undef AF_INET6
#define AF_INET6 10
// Extract the flow information from IPv6 headers (except top 4bits)
#define IPV6_FLOWINFO_MASK bpf_htonl(0x0FFFFFFF)

#ifndef memcpy
#define memcpy(dest, src, n) __builtin_memcpy((dest), (src), (n))
#endif /* memcpy */

static __always_inline int ip_decrease_ttl(struct iphdr *iph) {
  __u32 check = iph->check;
  check += bpf_htons(0x0100);
  iph->check = (__u16)(check + (check >= 0xFFFF));
  return --iph->ttl;
}

SEC("xdp")
int xdp_router_func(struct xdp_md *ctx) {
  void *data_end = (void *)(long)ctx->data_end;
  void *data = (void *)(long)ctx->data;

  // Forwarding Information Base
  // Data structure used by routers to make packet Forwarding decisions
  // Contains necessary routing info:
  // - Dest IP
  // - Next Hop Interface or MAC addr
  struct bpf_fib_lookup fib_params = {};

  struct ethhdr *eth = data;
  struct ipv6hdr *ip6h;
  struct iphdr *iph;

  __u16 h_proto;
  __u64 nh_off; // nh offset
  __u32 rc;
  __u32 action = XDP_PASS;

  nh_off = sizeof(*eth);

  // Ensure packet is large enough to hold the Ethernet header
  if (data + nh_off > data_end) {
    action = XDP_DROP;
    goto out;
  }

  // EtherType
  h_proto = eth->h_proto;
  if (h_proto == bpf_htons(ETH_P_IP)) {
    iph = data + nh_off;
    if ((void *)iph + 1 > data_end) {
      action = XDP_DROP;
      goto out;
    }

    // If TTL is ended, discard packet
    if (iph->ttl <= 1)
      goto out;

    // Populate the fib_params for AF_INET IPv4 routing
    // Can be used later to look up next hop information
    fib_params.family = AF_INET;
    fib_params.tos = iph->tos;
    fib_params.l4_protocol = iph->protocol;
    fib_params.sport = 0;
    fib_params.dport = 0;
    fib_params.tot_len = bpf_ntohs(iph->tot_len);
    fib_params.ipv4_src = iph->saddr;
    fib_params.ipv4_dst = iph->daddr;

  } else if (h_proto == bpf_htons(ETH_P_IPV6)) {
    struct in6_addr *src = (struct in6_addr *)fib_params.ipv6_src;
    struct in6_addr *dst = (struct in6_addr *)fib_params.ipv6_dst;

    ip6h = data + nh_off;
    if ((void *)ip6h + 1 > data_end) {
      action = XDP_DROP;
      goto out;
    }

    if (ip6h->hop_limit <= 1)
      goto out;

    fib_params.family = AF_INET6;
    fib_params.flowinfo = *(__be32 *)ip6h & IPV6_FLOWINFO_MASK;
    fib_params.l4_protocol = ip6h->nexthdr;
    fib_params.sport = 0;
    fib_params.dport = 0;
    fib_params.tot_len = 0;
    fib_params.tot_len = bpf_ntohs(ip6h->payload_len);
    *src = ip6h->saddr;
    *dst = ip6h->daddr;

  } else {
    goto out;
  }

  // Device Index for FIB lookup
  fib_params.ifindex = ctx->ingress_ifindex;

  // Perform L3 (network layer) FIB lookup and find next hop/ MAC addr
  rc = bpf_fib_lookup(ctx, &fib_params, sizeof(fib_params), 0);
  switch (rc) {
  case BPF_FIB_LKUP_RET_SUCCESS:
    // If successfully retrieved
    // - Decrease TTL / HopLimit
    // - Update src, dest MAC addr
    // - Forward the packet to next hop interface
    if (h_proto == bpf_htons(ETH_P_IP))
      ip_decrease_ttl(iph);
    else if (h_proto == bpf_htons(ETH_P_IPV6))
      ip6h->hop_limit--;

    memcpy(eth->h_dest, fib_params.dmac, ETH_ALEN);
    memcpy(eth->h_source, fib_params.smac, ETH_ALEN);
    action = bpf_redirect(fib_params.ifindex, 0);
    break;

  case BPF_FIB_LKUP_RET_BLACKHOLE:   /* dest is blackholed; can be dropped */
  case BPF_FIB_LKUP_RET_UNREACHABLE: /* dest is unreachable; can be dropped */
  case BPF_FIB_LKUP_RET_PROHIBIT:    /* dest not allowed; can be dropped */
    action = XDP_DROP;
    break;
  case BPF_FIB_LKUP_RET_NOT_FWDED:    /* packet is not forwarded */
  case BPF_FIB_LKUP_RET_FWD_DISABLED: /* fwding is not enabled on ingress */
  case BPF_FIB_LKUP_RET_UNSUPP_LWT:   /* fwd requires encapsulation */
  case BPF_FIB_LKUP_RET_NO_NEIGH:     /* no neighbor entry for nh */
  case BPF_FIB_LKUP_RET_FRAG_NEEDED:  /* fragmentation required to fwd */
    /* PASS */
    break;
  }

out:
  return xdp_stats_record_action(ctx, action);
}
