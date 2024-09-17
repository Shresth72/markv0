#ifndef __REWRITE_HELPERS_H
#define __REWRITE_HELPERS_H

#include <linux/if_ether.h>
#include <linux/ip.h>
#include <linux/ipv6.h>

/*
 * Swaps destination and source MAC addresses inside an Ethernet header
 */
static __always_inline void swap_src_dst_mac(struct ethhdr *eth) {
  __u8 h_tmp[ETH_ALEN];

  __builtin_memcpy(h_tmp, eth->h_source, ETH_ALEN);
  __builtin_memcpy(eth->h_source, eth->h_dest, ETH_ALEN);
  __builtin_memcpy(eth->h_dest, h_tmp, ETH_ALEN);
}

/*
 * Swaps destination and source IPv6 addresses inside an IPv6 header
 */
static __always_inline void swap_src_dst_ipv6(struct ipv6hdr *ipv6) {
  struct in6_addr tmp = ipv6->saddr;

  ipv6->saddr = ipv6->daddr;
  ipv6->daddr = tmp;
}

/*
 * Swaps destination and source IPv4 addresses inside an IPv4 header
 */
static __always_inline void swap_src_dst_ipv4(struct iphdr *iphdr) {
  __be32 tmp = iphdr->saddr;

  iphdr->saddr = iphdr->daddr;
  iphdr->daddr = tmp;
}

#endif /* __REWRITE_HELPERS_H */
