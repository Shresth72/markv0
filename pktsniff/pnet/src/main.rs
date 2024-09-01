mod config;
mod tcp;

use std::collections::HashMap;
use std::fs;
use std::thread::sleep;
use std::time::Duration;

use config::*;
use tcp::*;

use pcap;
use pnet::{
    self,
    packet::{
        ethernet::{EtherTypes, EthernetPacket},
        ip::IpNextHeaderProtocols,
        ipv4::Ipv4Packet,
        tcp::TcpPacket,
        udp::UdpPacket,
        Packet,
    },
};

struct IpStats {
    sent: u64,
    received: u64,
}

fn main() {
    let config_content = fs::read_to_string("config.toml").expect("Failed to read config file");
    let config: Config = toml::from_str(&config_content).expect("Failed to parse config file");

    let interface = "eth0";
    let mut cap = pcap::Capture::from_device(interface)
        .expect("Failed to open device")
        .promisc(false)
        .snaplen(5000)
        .open()
        .expect("Failed to open capture");

    let mut ip_map: HashMap<String, IpStats> = HashMap::new();

    loop {
        for _ in 0..10 {
            // Collect data from 10 packets at a time
            if let Ok(packet) = cap.next_packet() {
                if let Some(ethernet_packet) = EthernetPacket::new(&packet.data) {
                    process_packet(&ethernet_packet, &config, &mut ip_map);
                }
            }
        }

        display_summary(&ip_map);
        sleep(Duration::from_millis(500));
    }
}

fn process_packet(
    ethernet_packet: &EthernetPacket,
    config: &Config,
    ip_map: &mut HashMap<String, IpStats>,
) {
    match ethernet_packet.get_ethertype() {
        EtherTypes::Ipv4 => {
            if let Some(ipv4_packet) = Ipv4Packet::new(ethernet_packet.payload()) {
                match ipv4_packet.get_next_level_protocol() {
                    IpNextHeaderProtocols::Tcp => {
                        if let Some(tcp_packet) = TcpPacket::new(ipv4_packet.payload()) {
                            handle_tcp_packet(&ipv4_packet, &tcp_packet, &config);
                        }
                    }
                    IpNextHeaderProtocols::Udp => {
                        if let Some(udp_packet) = UdpPacket::new(ipv4_packet.payload()) {
                            handle_udp_packet(&ipv4_packet, &udp_packet);
                        }
                    }
                    _ => {}
                }

                update_ip_stats(
                    ip_map,
                    ipv4_packet.get_source().to_string(),
                    true,
                    ipv4_packet.get_header_length().into(),
                );
                update_ip_stats(
                    ip_map,
                    ipv4_packet.get_destination().to_string(),
                    false,
                    ipv4_packet.get_header_length().into(),
                );
            }
        }
        _ => {}
    }
}

fn handle_udp_packet(ipv4_packet: &Ipv4Packet, udp_packet: &UdpPacket) {
    println!(
        "UDP Packet: {}:{} > {}:{}; Len: {}",
        ipv4_packet.get_source(),
        udp_packet.get_source(),
        ipv4_packet.get_destination(),
        udp_packet.get_destination(),
        udp_packet.get_length()
    );
}

fn update_ip_stats(
    ip_map: &mut HashMap<String, IpStats>,
    ip: String,
    is_source: bool,
    packet_size: usize,
) {
    let stats = ip_map.entry(ip).or_insert(IpStats {
        sent: 0,
        received: 0,
    });
    if is_source {
        stats.sent += packet_size as u64;
    } else {
        stats.received += packet_size as u64;
    }
}

fn display_summary(ip_map: &HashMap<String, IpStats>) {
    println!("IP Address        | Packets Sent | Packets Received");
    println!("------------------+--------------+-----------------");
    for (ip, stats) in ip_map {
        println!("{:<18} | {:<12} | {}", ip, stats.sent, stats.received);
    }
}
