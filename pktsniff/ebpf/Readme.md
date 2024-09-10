# eBPF

Extended Berkeley Packet Filter, provides programmable hooks into the Linux Kernel, enabling developers to run custom bytecode within the `Kernel Space` without the need to change kernel source code or load kernel modules. Designed originally for packet filtering, eBPF has evolved to support a ranfe of functionailities, turning it into a versatile, in-kernel virtual machine.

These programs are `Event Driven`, executing when the kernel or app traverses a specific hook point. Predefined hooks encompass system calls, function entries/exits, kernel tracepoints, network events, and several additional instances.

```
          `Process`
              |
   K          | execve()
   E          |
   R      `Syscall`
   N          |
   E          --------> `eBPF`
   L          |
              v
          `Scheduler`
```

```c
#include <linux/bpf.h>

int syscall__ret_execve(struct pt_regs *ctx) {
    struct comm_event event = {
        .pid = bpf_get_current_pid_tgid() >> 32,
        .type = TYPE_RETURN,
    }

    bpf_get_current_comm(&event.comm, sizeof(event.comm));
    comm_events.perf_submit(ctx, &event, sizeof(event));

    return 0;
}
```

- So, we can have a `User Space` application initiating a system call to the Linux Kernel. An eBPF program can intercept the call at the System Call Interface, illustrating how eBPF can monitor or alter system behaviour through syscal hooking.
- Hence, eBPF can work as a bridge between the `User Space` and `Kernel Space` interaction, enabling enhanced monitoring and customization.

## Resources

- [eBPF Tutorial](https://www.youtube.com/watch?v=uBqRv8bDroc)
- [eBPF Network Programming](https://ebpf.io/)

# Kprobe and Kretprobe

The tools kprobe and kretprobe are probing mechanisms within the eBPF ecosystem. kprobe is used to inspect data at the entry of a kernel function, while kretprobe is used at the function's exit. Together, these tools allow us to monitor, analyze, and debug kernel behaviors by capturing both function arguments and return values. Specifically, kretprobe, in particular, is crucial because it captures the return values, showing the result of kernel function calls. This way, we can get a full picture of how functions behave, helping us to understand the system better.

```
             Kernel Function
              "openat,clone"
             ---------------
             |             |
             |             |
             |-------------|
Kprobe -->   | Entry Point |
             |     args    |
             |-------------|
             |             |
             |   Function  |
             |    Body     |
             |             |
             |-------------|
Kretprobe -> | Exit Point  |
             |return values|
             |-------------|
```
