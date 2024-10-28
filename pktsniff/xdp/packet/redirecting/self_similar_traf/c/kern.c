#include <linux/bpf.h>
#include <linux/if_ether.h>
#include <linux/in.h>

#include <bpf/bpf_endian.h>
#include <bpf/bpf_helpers.h>

#define MAX_SOURCES 4
#define MAX_QUEUE_LENGTH 1000

struct source_state {
  __u64 active; // 1: active, 0: inactive
  __u64 intensity1;
  __u64 intensity2;
  __u64 transition_rate1; // Transition rate from state 1 to state 2
  __u64 transition_rate2; // Transition rate from state 2 to state 1
  __u64 last_transition;  // Timestamp of the last state transition
};

struct {
  __uint(type, BPF_MAP_TYPE_ARRAY);
  __type(key, __u32);
  __type(value, struct source_state);
  __uint(max_entries, MAX_SOURCES);
} source_states SEC(".maps");

struct {
  __uint(type, BPF_MAP_TYPE_ARRAY);
  __type(key, __u32);
  __type(value, __u64); // Queue length
  __uint(max_entries, 1);
} queue_length_map SEC(".maps");

static __always_inline void update_source_state(__u32 i) {
  __u64 now = bpf_ktime_get_ns(); // Current timestamp in nanoseconds
  struct source_state *state = bpf_map_lookup_elem(&source_states, &i);

  if (state) {
    __u64 time_elapsed = now - state->last_transition;

    // Determine transition rates (convert transition rates to nanoseconds)
    __u64 rate1_ns = state->transition_rate1 * 1000000000ULL;
    __u64 rate2_ns = state->transition_rate2 * 1000000000ULL;

    // Transition from state 1 to 2
    if (state->active && time_elapsed > rate1_ns) {
      state->active = 0;
      state->last_transition = now;
    }
    // Transition from state 2 to 1
    else if (!state->active && time_elapsed > rate2_ns) {
      state->active = 1;
      state->last_transition = now;
    }
  }
}

static __always_inline int handle_packet(struct xdp_md *ctx) {
  __u64 *queue_length = bpf_map_lookup_elem(&queue_length_map, &(__u32){0});
  if (!queue_length) {
    return XDP_DROP; // Drop if queue length not found
  }

  // Check the current queue length and apply shaping logic
  if (*queue_length < MAX_QUEUE_LENGTH) {
    // Allow the packet and increment queue length
    *queue_length += 1;
    return XDP_PASS; // Let the packet through
  } else {
    // Drop the packet if the queue is full
    return XDP_DROP;
  }
}

SEC("xdp_redirect_map")
int xdp_redirect_map_func(struct xdp_md *ctx) {
  // Unroll the loop manually for eBPF verifier
  update_source_state(0);
  update_source_state(1);
  update_source_state(2);
  update_source_state(3);

  return handle_packet(ctx); // Handle the packet based on queue length
}

char _license[] SEC("license") = "GPL";
