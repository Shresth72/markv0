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

static __always_inline __u16 csum_fold_helper(__u32 csum) {
  __u32 sum;
  sum = (csum >> 16) + (csum & 0xffff);
  sum += (sum >> 16);
  return ~sum;
}

static __always_inline __u16
icmp_checksum_diff(__u16 seed, struct icmphdr_common *icmphdr_new,
                   struct icmphdr_common *icmphdr_old) {
  __u32 csum, size = sizeof(struct icmphdr_common);

  // Update checksum
  // Calculates difference bw the old and new header over the size bytes
  // includes the dest port
  // seed: helps adject the checksum correctly (bitwise neg of original csum)

  csum = bpf_csum_diff((__be32 *)icmphdr_old, size, (__be32 *)icmphdr_new, size,
                       seed);

  return csum_fold_helper(csum);
}

// Send back ICMP_ECHOREPLY when icmp received
SEC("xdp")
int xdp_icmp_echo_func(struct xdp_md *ctx) {
  void *data_end = (void *)(long)ctx->data_end;
  void *data = (void *)(long)ctx->data;

  struct hdr_cursor nh;
  struct ethhdr *eth;

  int eth_type;
  int ip_type;
  int icmp_type;

  struct iphdr *iphdr;
  struct ipv6hdr *ipv6hdr;

  __u16 echo_reply;
  __u16 old_csum;

  struct icmphdr_common *icmphdr;
  struct icmphdr_common icmphdr_old;

  __u32 action = XDP_PASS;

  nh.pos = data;

  // Parse Ethernet and IP/IPv6 headers
  eth_type = parse_ethhdr(&nh, data_end, &eth);
  if (eth_type < 0) {
    action = XDP_ABORTED;
    goto out;
  }

  if (eth_type == bpf_htons(ETH_P_IP)) {
    ip_type = parse_iphdr(&nh, data_end, &iphdr);
    if (ip_type != IPPROTO_ICMP)
      goto out;
  } else if (eth_type == bpf_htons(ETH_P_IPV6)) {
    ip_type = parse_ip6hdr(&nh, data_end, &ipv6hdr);
    if (ip_type != IPPROTO_ICMPV6)
      goto out;
  } else {
    goto out;
  }

  // Parser returns struct containing 'protocol-independent' part of
  // and ICMP or ICMPv6 header
  icmp_type = parse_icmphdr_common(&nh, data_end, &icmphdr);
  if (eth_type == bpf_htons(ETH_P_IP) && icmp_type == ICMP_ECHO) {
    swap_src_dst_ipv4(iphdr);
    echo_reply = ICMP_ECHOREPLY;
  } else if (eth_type == bpf_htons(ETH_P_IPV6) &&
             icmp_type == ICMPV6_ECHO_REQUEST) {
    swap_src_dst_ipv6(ipv6hdr);
    echo_reply = ICMPV6_ECHO_REPLY;
  } else {
    goto out;
  }

  // Swap Ethernet source and destination
  swap_src_dst_mac(eth);

  // Patch the packet and udpate the checksum.
  old_csum = icmphdr->cksum;
  icmphdr->cksum = 0;
  icmphdr_old = *icmphdr;
  icmphdr->type = echo_reply;
  icmphdr->cksum = icmp_checksum_diff(~old_csum, icmphdr, &icmphdr_old);

  // TODO: Send back the echo_reply

  bpf_printk("echo_reply: %d", echo_reply);
  action = XDP_TX;

out:
  return xdp_stats_record_action(ctx, action);
}
