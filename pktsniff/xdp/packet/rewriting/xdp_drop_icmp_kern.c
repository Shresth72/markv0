#include <linux/bpf.h>
#include <linux/if_ether.h>
#include <linux/in.h>

#include <bpf/bpf_endian.h>
#include <bpf/bpf_helpers.h>

#include "../common_user.h"
#include "../parsers.h"

#include "../common.h"

/*
 Parses both IPv6 and IPv4 packets and checks for ICMP and ICMPv6 types
 It drops packets based on ICMP sequence number

 (Internet Control Message Protocol is a network layer protocol used by
 devices such as routers and hosts to send error messages and operational
 information)
*/
SEC("xdp")
int xdp_parser_func(struct xdp_md *ctx) {
  void *data_end = (void *)(long)ctx->data_end;
  void *data = (void *)(long)ctx->data;

  __u32 action = XDP_PASS;

  struct hdr_cursor nh;
  int nh_type;
  nh.pos = data;

  struct ethhdr *eth;

  nh_type = parse_ethhdr(&nh, data_end, &eth);

  // IPv6
  if (nh_type == bpf_htons(ETH_P_IPV6)) {
    struct ipv6hdr *ipv6h;
    struct icmp6hdr *icmp6vh;

    nh_type = parse_ip6hdr(&nh, data_end, &ipv6h);
    if (nh_type != IPPROTO_ICMPV6)
      goto out;

    nh_type = parse_icmp6hdr(&nh, data_end, &icmp6vh);
    if (nh_type != ICMPV6_ECHO_REQUEST)
      goto out;

    if (bpf_ntohs(icmp6vh->icmp6_sequence) % 2 == 0)
      action = XDP_DROP;
  }
  // IPv4
  else if (nh_type == bpf_ntohs(ETH_P_IP)) {
    struct iphdr *iph;
    struct icmphdr *icmph;

    nh_type = parse_iphdr(&nh, data_end, &iph);
    if (nh_type != IPPROTO_ICMP)
      goto out;

    nh_type = parse_icmphdr(&nh, data_end, &icmph);
    if (nh_type != ICMP_ECHO)
      goto out;

    if (bpf_ntohs(icmph->un.echo.sequence) % 2 == 0)
      action = XDP_DROP;
  }

out:
  return xdp_stats_record_action(ctx, action);
}
