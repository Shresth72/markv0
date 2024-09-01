use pnet::packet::{ipv4::Ipv4Packet, tcp::TcpPacket};

use crate::{send_alert, Config};

pub fn handle_tcp_packet(ipv4_packet: &Ipv4Packet, tcp_packet: &TcpPacket, config: &Config) {
    println!(
        "TCP Packet: {}:{} > {}:{}; Seq: {}, Ack: {}",
        ipv4_packet.get_source(),
        tcp_packet.get_source(),
        ipv4_packet.get_destination(),
        tcp_packet.get_destination(),
        tcp_packet.get_sequence(),
        tcp_packet.get_acknowledgement()
    );

    if config.general.mode == "detailed" {
        // Detailed logging
    } else if config.general.mode == "summary" {
        // Summary logging
    }

    if tcp_packet.get_destination() == config.alert.port
        && ipv4_packet.get_source().to_string() == config.alert.ip
    {
        send_alert(&config.alert.ip, config.alert.port);
    }
}
