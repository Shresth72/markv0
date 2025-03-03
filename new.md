## How is cyber security handled generally?
- Through Firewalls, by controlling incoming traffic
- Intrusion Detection, monitoring suspicious activity
- Antivirus, removing harmful software
- Encryption, etc

## Layers at which these are handled
- Physical Layer
- Network Layer
- Application Layer: Application firewalls, security testing
- Data Layer: Encryption, Access Controls

## How and where are handling it?
- Handling it directly, at the earliest; at the Kernel Layer (before Network Layer)
- Enforces strict access control and network monitoring
- Works via syscall, directly over the NIC (Network Interface Card)
- Really performant
- Obscures away the handling logic from the higher levels, and only offers the data
- Which can be handled later by the application/user layer.

# Programmable Kernel (eBPF)
- Able to modify the behaviour of the kernel
- Works as a seperate small Middleware Virtual Machine bw the kernel and user space
- Attach directly to a NIC, and handle everything custom just for that device
- No need to wait for changes in your operating system
- Can be used with kubernetes to directly, modify the behaviour of the control system
    - Behaviour of network or events can be modified for each and every pod, by directly changing the kernel behaviour
    - Gives a more faster and consistent approach to handle this
- User space can just handle all the calculation and presentation logics, and not waste kernel resources
- Useful for system call events too, and capture every event at the earliest. Event types: 
    - Kprobes
    - Uprobes
    - Network packets
    - Tracepoints 
    - Perf events (Bubble up events from the kernel)

# Uses
- Kubernetes (Change pod behaviours at the kernel level)
- Debugging and capturing low level events (which are often really hard to handle)
- Monitoring and modifying network traffic (firewall)

# Without NIC Offloading
1. Packet arrives at the physical Network Interface Card (NIC) from the outside world.
2. Our NIC processes the packet and generates an interuppt (syscall) to signal the CPU.
3. The Linux kernel recieved the interuppt and schedules the appropriate driver to handle the incoming packet.
4. The packet is placed in a recieve buffer by the NIC buffer.
5. The eBPF XDP program is executed by the kernel, processing the packet before it reaches the full network stack.
6. Handle the XDP action chosen by the eBPF program.
7. Pass through to the Linux networking stack.
8. The packet is handed off to the appropriate socket buffer.
9. The userspace application reads the packet from the socket buffer.

# With NIC Offloading
1. Packet arrives at the physical Network Interface Card (NIC) from the outside world.
2. The eBPF XDP program is executed directly on the NIC hardware, processing the packet before it reaches the linux kernel.
3. Handle the XDP action chosen by the eBPF program.


# user space -> (eBPF)vm -> kernel





# eBPF Maps
Maps are generic data structure for storage of different types of data. They allow sharing of data between eBPF kernel programs,
and also between kernel and user-space applications

Each map type has the following attributes:
- type 
- maximum number of elements
- key size in bytes
- value size in bytes
