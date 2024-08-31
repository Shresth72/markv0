use pcap;
use pnet::{
    self,
    packet::{
        ethernet::{EtherTypes, EthernetPacket},
        ip::IpNextHeaderProtocols,
        ipv4::Ipv4Packet,
        // ipv6::Ipv6Packet,
        tcp::TcpPacket,
        udp::UdpPacket,
        Packet,
    },
};

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
        // Parse the Ethernet frame from the captured packet data
        if let Some(ethernet_packet) = EthernetPacket::new(&packet.data) {
            match ethernet_packet.get_ethertype() {
                EtherTypes::Ipv4 => {
                    if let Some(ipv4_packet) = Ipv4Packet::new(ethernet_packet.payload()) {
                        match ipv4_packet.get_next_level_protocol() {
                            IpNextHeaderProtocols::Tcp => {
                                if let Some(tcp_packet) = TcpPacket::new(ipv4_packet.payload()) {
                                    println!(
                                        "TCP Packet: {}:{} > {}:{}; Seq: {}, Ack: {}",
                                        ipv4_packet.get_source(),
                                        tcp_packet.get_source(),
                                        ipv4_packet.get_destination(),
                                        tcp_packet.get_destination(),
                                        tcp_packet.get_sequence(),
                                        tcp_packet.get_acknowledgement()
                                    );
                                }
                            }
                            IpNextHeaderProtocols::Udp => {
                                if let Some(udp_packet) = UdpPacket::new(ipv4_packet.payload()) {
                                    println!(
                                        "UDP Packet: {}:{} > {}:{}; Len: {}",
                                        ipv4_packet.get_source(),
                                        udp_packet.get_source(),
                                        ipv4_packet.get_destination(),
                                        udp_packet.get_destination(),
                                        udp_packet.get_length()
                                    );
                                }
                            }
                            _ => {}
                        }
                    }
                }
                _ => {}
            }
        }
    }
}
