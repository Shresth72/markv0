#include <linux/bpf.h>
#include <linux/if_ether.h>
#include <linux/in.h>

#include <bpf/bpf_endian.h>
#include <bpf/bpf_helpers.h>

// Define constants
#define MAX_SOURCES 4
#define WINDOW_SIZE 1000000000 // 1 second in nanoseconds
#define MAX_QUEUE_SIZE 5000
#define SCALE_FACTOR 1000000

// Structure to represent an MMPP source (Markov Modulated Poisson Process) -
// Switched Poisson Process
struct mmpp_source {
  __u64 lambda1;
  __u64 lambda2;
  __u64 c1;
  __u64 c2;
  __u64 current_state;
};

struct {
  __uint(type, BPF_MAP_TYPE_ARRAY);
  __type(key, __u32);
  __type(value, struct mmpp_source);
  __uint(max_entries, MAX_SOURCES);
} mmpp_sources SEC(".maps");

struct {
  __uint(type, BPF_MAP_TYPE_ARRAY);
  __type(key, __u32);
  __type(value, __u64);
  __uint(max_entries, 1);
} window_start SEC(".maps");

struct {
  __uint(type, BPF_MAP_TYPE_ARRAY);
  __type(key, __u32);
  __type(value, __u64);
  __uint(max_entries, 1);
} packet_count SEC(".maps");

struct {
  __uint(type, BPF_MAP_TYPE_ARRAY);
  __type(key, __u32);
  __type(value, __u64);
  __uint(max_entries, 1);
} average_count SEC(".maps");

struct {
  __uint(type, BPF_MAP_TYPE_ARRAY);
  __type(key, __u32);
  __type(value, __u64);
  __uint(max_entries, 1);
} queue_size SEC(".maps");

SEC("xdp")
int xdp_traffic_shaper(struct xdp_md *ctx) {
  __u64 now = bpf_ktime_get_ns();
  __u32 key = 0;
  __u64 *window_start_ptr = bpf_map_lookup_elem(&window_start, &key);
  __u64 *packet_count_ptr = bpf_map_lookup_elem(&packet_count, &key);
  __u64 *average_count_ptr = bpf_map_lookup_elem(&average_count, &key);
  __u64 *queue_size_ptr = bpf_map_lookup_elem(&queue_size, &key);

  if (!window_start_ptr || !packet_count_ptr || !average_count_ptr ||
      !queue_size_ptr)
    return XDP_ABORTED;

  // Check if we need to start a new window
  if (now - *window_start_ptr >= WINDOW_SIZE) {
    // Calculate new average
    __u64 new_average =
        ((*average_count_ptr * 900) + (*packet_count_ptr * 100)) / SCALE_FACTOR;
    *average_count_ptr = new_average;

    // Reset window
    *window_start_ptr = now;
    *packet_count_ptr = 0;
  }

  // Increment packet count
  (*packet_count_ptr)++;

  // Calculate current traffic rate
  __u64 current_rate =
      (*packet_count_ptr * SCALE_FACTOR) / (now - *window_start_ptr);

  // Simple traffic shaping: drop packet if current rate exceeds average rate
  if (current_rate > *average_count_ptr) {
    if (*queue_size_ptr >= MAX_QUEUE_SIZE) {
      return XDP_DROP;
    } else {
      (*queue_size_ptr)++;
    }
  } else if (*queue_size_ptr > 0) {
    (*queue_size_ptr)--;
  }

  return XDP_PASS;
}

char _license[] SEC("license") = "GPL";
