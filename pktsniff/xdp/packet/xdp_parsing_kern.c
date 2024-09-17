#include <linux/bpf.h>
#include <linux/if_ether.h>
#include <linux/if_packet.h>
#include <linux/in.h>
#include <linux/ip.h>
#include <linux/ipv6.h>
#include <linux/tcp.h>
#include <linux/udp.h>
#include <stddef.h>

#include <bpf/bpf_endian.h>
#include <bpf/bpf_helpers.h>

#include "../common_user.h"

#include "../common.h"

// Holds a pointer `pos` used to traverse and parse packet headers
struct hdr_cursor {
  void *pos;
};

/*
  Each helper parses a packet header, including doing bounds checking, and
  returns the type of its contents if successful, and -1 otherwise

  For Ethernet and IP headers, the content type is the type of the payload
  (h_proto for Ethernet, nexthdr for IPv6), for ICMP it is the ICMP type field.
  All return values are in host byte order.

  - Checks if there's enough data left to read the Ethernet header
  - Updates the cursor position and stores the Ethernet header
  - Returns the EtherType (the type of payload), which indicates the next header
  type
*/
static __always_inline int parse_ethhdr(struct hdr_cursor *nh, void *data_end,
                                        struct ethhdr **ethhdr) {

  // Cast the current position to an Ethernet header pointer
  struct ethhdr *eth = nh->pos;
  int hdrsize = sizeof(*eth);

  // Byte count bounds check;
  // check if current pointer + size of header is after data_end
  if (nh->pos + 1 > data_end)
    return -1;

  // Advance the cursor position by size of the Ethernet header
  nh->pos += hdrsize;
  // Store
  *ethhdr = eth;

  // Return EtherType
  return eth->h_proto;
}

static __always_inline int parse_ip6hdr(struct hdr_cursor *nh, void *data_end,
                                        struct ipv6hdr **ipv6hdr) {
  struct ipv6hdr *ip6h = nh->pos;

  if ((void *)ip6h + 1 > data_end)
    return -1;

  nh->pos = ip6h + 1;
  *ipv6hdr = ip6h;

  return ip6h->nexthdr;
}

static __always_inline int parse_udphdr(struct hdr_cursor *nh, void *data_end,
                                        struct udphdr **udphdr) {
  int len;
  struct udphdr *h = nh->pos;

  if ((void *)h + 1 > data_end)
    return -1;

  nh->pos = h + 1;
  *udphdr = h;

  len = bpf_ntohs(h->len) - sizeof(struct udphdr);
  if (len < 0)
    return -1;

  return len;
}

static __always_inline int parse_tcphdr(struct hdr_cursor *nh, void *data_end,
                                        struct tcphdr **tcphdr) {
  int len;
  struct tcphdr *h = nh->pos;

  if ((void *)h + 1 > data_end)
    return -1;

  len = h->doff * 4;
  if (len < sizeof(*h))
    return -1;

  if (nh->pos + len > data_end)
    return -1;

  nh->pos += len;
  *tcphdr = h;

  return len;
}

SEC("xdp")
int xdp_parser_func(struct xdp_md *ctx) {

  // Initializes `data_end` and `data` pointers from the XDP context
  void *data_end = (void *)(long)ctx->data_end;
  void *data = (void *)(long)ctx->data;
  struct ethhdr *eth;

  // Default action
  __u32 action = XDP_PASS;

  // Keep track of next header type and iterator pointer
  struct hdr_cursor nh;
  int nh_type;

  // Start next header cursor position at data start
  nh.pos = data;

  // Get the payload type
  nh_type = parse_ethhdr(&nh, data_end, &eth);
  if (nh_type != bpf_htons(ETH_P_IPV6))
    goto out;

  action = XDP_DROP;

out:
  // Record the action and return it
  return xdp_stats_record_action(ctx, action);
}
