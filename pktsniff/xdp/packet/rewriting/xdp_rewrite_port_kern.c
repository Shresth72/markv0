#include <linux/bpf.h>
#include <linux/in.h>

#include <bpf/bpf_endian.h>
#include <bpf/bpf_helpers.h>

#include "../common_user.h"
#include "../parsers.h"

#include "../common.h"

SEC("xdp_rewrite_ports")
int xdp_patch_ports_func(struct xdp_md *ctx) {
  int action = XDP_PASS;
  int eth_type, ip_type;

  struct ethhdr *eth;
  struct iphdr *iphdr;
  struct ipv6hdr *ipv6hdr;
  struct udphdr *udphdr;
  struct tcphdr *tcphdr;

  void *data_end = (void *)(long)ctx->data_end;
  void *data = (void *)(long)ctx->data;
  struct hdr_cursor nh = {.pos = data};

  eth_type = parse_ethhdr(&nh, data_end, &eth);
  if (eth_type < 0) {
    action = XDP_ABORTED;
    goto out;
  }

  if (eth_type == bpf_htons(ETH_P_IP)) {
    ip_type = parse_iphdr(&nh, data_end, &iphdr);
  } else if (eth_type == bpf_htons(ETH_P_IPV6)) {
    ip_type = parse_ip6hdr(&nh, data_end, &ipv6hdr);
  } else {
    goto out;
  }

  if (ip_type == IPPROTO_UDP) {
    if (parse_udphdr(&nh, data_end, &udphdr) < 0) {
      action = XDP_ABORTED;
      goto out;
    }

    /*
     We need to update the packet checksum when modifying the header
     PFC1071 contans an algo for in-place updating, we use that
     since we're always just decrementing the port number.
     Another way would be recompute the full checksum

     - Initialize csum for the current value: udphdr->check
     - Maintaina a copy of old udphdr
     - bpf_ntohs(udphdr->dest): Convert dest port from big-endian to
     little-endian
     - bpf_ntohs(udphdr->dest) - 1: decrement dest port
     - Update the checksum, by recalculating it

     struct udphdr udphdr_old;
     __u32 csum = udphdr->check;
     udphdr_old = *udphdr;
     udphdr->dest = bpf_htons(bpf_ntohs(udphdr->dest) - 1);
     csum = bpf_csum_diff((__be32 *)&udphdr_old, 4, (__be32 *)udphdr, 4, ~csum);
     udphdr->check = csum_fold_helper(csum);
    */

    // RFC1071
    udphdr->dest = bpf_htons(bpf_ntohs(udphdr->dest) - 1);
    udphdr->check += bpf_htons(1);
    if (!udphdr->check)
      udphdr->check += bpf_htons(1);
  } else if (ip_type == IPPROTO_TCP) {
    if (parse_tcphdr(&nh, data_end, &tcphdr) < 0) {
      action = XDP_ABORTED;
      goto out;
    }

    tcphdr->dest = bpf_htons(bpf_ntohs(tcphdr->dest) - 1);
    tcphdr->check += bpf_htons(1);
    if (!tcphdr->check)
      tcphdr->check += bpf_htons(1);
  }

out:
  return xdp_stats_record_action(ctx, action);
}
