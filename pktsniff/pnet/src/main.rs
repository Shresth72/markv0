use pcap;
use pnet;

fn main() {
    let interface = "eth0";

    // Open capture for interface
    let mut cap = pcap::Capture::from_device(interface)
        .unwrap()
        .promisc(true) // capture mode promiscuous
        .snaplen(5000) // maximum bytes to capture per packet
        .open()
        .unwrap();

    while let Ok(packet) = cap.next_packet() {
        println!("Received packet with length {}", packet.header.len);
        // Add filtering and processing
    }
}
