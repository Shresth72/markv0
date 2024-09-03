use pnet::packet::ip::IpNextHeaderProtocols;
use pnet::packet::{ipv4::Ipv4Packet, tcp::TcpPacket, udp::UdpPacket, Packet};
use std::io;
use tun_tap::{Iface, Mode};

fn main() -> io::Result<()> {
    // Create the TUN interface
    let iface = Iface::without_packet_info("tun0", Mode::Tun)?;

    println!("TUN interface created: tun0");

    // Buffer for reading packets
    let mut buf = [0u8; 1504];

    loop {
        // Read packets from the TUN interface
        let nbytes = iface.recv(&mut buf)?;

        if nbytes > 0 {
            // Parse the packet
            if let Some(ipv4_packet) = Ipv4Packet::new(&buf[..nbytes]) {
                println!(
                    "Captured IPv4 packet from {} to {}",
                    ipv4_packet.get_source(),
                    ipv4_packet.get_destination()
                );

                // Check if the packet is TCP or UDP
                match ipv4_packet.get_next_level_protocol() {
                    IpNextHeaderProtocols::Tcp => {
                        if let Some(tcp_packet) = TcpPacket::new(ipv4_packet.payload()) {
                            println!(
                                "TCP Packet: Src Port: {}, Dst Port: {}",
                                tcp_packet.get_source(),
                                tcp_packet.get_destination()
                            );
                        }
                    }
                    IpNextHeaderProtocols::Udp => {
                        if let Some(udp_packet) = UdpPacket::new(ipv4_packet.payload()) {
                            println!(
                                "UDP Packet: Src Port: {}, Dst Port: {}",
                                udp_packet.get_source(),
                                udp_packet.get_destination()
                            );
                        }
                    }
                    _ => {
                        println!("Non-TCP/UDP packet");
                    }
                }
            } else {
                println!("Failed to parse IPv4 packet");
            }
        }
    }
}
