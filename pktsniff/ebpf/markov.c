#include <bpf/bpf_endian.h>
#include <linux/bpf.h>
#include <linux/if_ether.h>
#include <linux/ip.h>
#include <linux/tcp.h>
#include <linux/udp.h>

#include <bpf/bpf_helpers.h>

struct perf_trace_event {
  __u64 timestamp;
  __u32 processing_time_ns;
  __u8 type;
  __u8 protocol;
  __u16 src_port;
  __u16 dst_port;
};

#define TYPE_ENTER 1
#define TYPE_DROP 2
#define TYPE_PASS 3
#define IPPROTO_TCP 6
#define IPPROTO_UDP 17

struct {
  __uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
  __uint(key_size, sizeof(int));
  __uint(value_size, sizeof(int));
  __uint(max_entries, 1024);
} output_map SEC(".maps");

SEC("xdp")
int xdp_lib(struct xdp_md *ctx) {
  void *data_end = (void *)(long)ctx->data_end;
  void *data = (void *)(long)ctx->data;
  struct ethhdr *eth = data;

  if ((void *)(eth + 1) > data_end)
    return XDP_PASS;

  if (eth->h_proto != bpf_htons(ETH_P_IP))
    return XDP_PASS;

  struct iphdr *ip = (void *)(eth + 1);
  if ((void *)(ip + 1) > data_end)
    return XDP_PASS;

  struct perf_trace_event e = {};
  e.timestamp = bpf_ktime_get_ns();
  e.type = TYPE_ENTER;
  e.protocol = ip->protocol;

  if (ip->protocol == IPPROTO_TCP) {
    struct tcphdr *tcp = (void *)(ip + 1);
    if ((void *)(tcp + 1) > data_end)
      return XDP_PASS;
    e.src_port = bpf_ntohs(tcp->source);
    e.dst_port = bpf_ntohs(tcp->dest);
  } else if (ip->protocol == IPPROTO_UDP) {
    struct udphdr *udp = (void *)(ip + 1);
    if ((void *)(udp + 1) > data_end)
      return XDP_PASS;
    e.src_port = bpf_ntohs(udp->source);
    e.dst_port = bpf_ntohs(udp->dest);
  } else {
    e.src_port = 0;
    e.dst_port = 0;
  }

  bpf_perf_event_output(ctx, &output_map, BPF_F_CURRENT_CPU, &e, sizeof(e));

  if (bpf_get_prandom_u32() % 2 == 0) {
    e.type = TYPE_DROP;
    __u64 ts = bpf_ktime_get_ns();
    e.processing_time_ns = ts - e.timestamp;
    e.timestamp = ts;
    bpf_perf_event_output(ctx, &output_map, BPF_F_CURRENT_CPU, &e, sizeof(e));
    return XDP_DROP;
  }

  e.type = TYPE_PASS;
  __u64 ts = bpf_ktime_get_ns();
  e.processing_time_ns = ts - e.timestamp;
  e.timestamp = ts;
  bpf_perf_event_output(ctx, &output_map, BPF_F_CURRENT_CPU, &e, sizeof(e));

  return XDP_PASS;
}

char _license[] SEC("license") = "GPL";
