use std::{
    io::{self, Read},
    net::{SocketAddr, TcpListener as StdTcpListener, TcpStream},
    usize,
};

use rand::Rng;

use crate::InterfaceHandle;

pub struct Connection {}

pub struct TcpListener {
    pub port: u16,
    pub ih: InterfaceHandle,
}

impl TcpListener {
    pub fn accept(&self) -> io::Result<(TcpStream, SocketAddr)> {
        let listener = StdTcpListener::bind(("0.0.0.0", self.port))?;
        listener.accept()
    }
}

pub fn handle_early_burst(nic: &mut tun_tap::Iface, _ih: &InterfaceHandle) -> io::Result<()> {
    const MIN_THRESH: u64 = 1000;
    const MAX_THRESH: u64 = 5000;
    const WEIGHT: f64 = 0.002;
    const DROP_PROB_MAX: u64 = 100;

    let mut rng = rand::thread_rng();
    let mut avg_queue_len: f64 = 0.0;
    let mut passed_packets = 0;
    let mut dropped_packets = 0;

    loop {
        let mut buf = [0u8; 1504];
        let nbytes = nic.recv(&mut buf)?;

        let current_queue_len = rng.gen_range(0..6000) as f64;

        avg_queue_len = (1.0 - WEIGHT) * avg_queue_len + WEIGHT * current_queue_len;

        let action = if avg_queue_len > MAX_THRESH as f64 {
            dropped_packets += 1;
            eprintln!("Packet dropped: Queue length exceeded MAX_THRESH");
            "DROP"
        } else if avg_queue_len < MIN_THRESH as f64 {
            passed_packets += 1;
            eprintln!("Packet passed: Queue length below MIN_THRESH");
            "PASS"
        } else {
            let drop_prob = ((avg_queue_len - MIN_THRESH as f64)
                / (MAX_THRESH as f64 - MIN_THRESH as f64))
                * DROP_PROB_MAX as f64;

            if rng.gen_range(0..100) < drop_prob as u64 {
                dropped_packets += 1;
                eprintln!("Packet dropped: Drop probability triggered");
                "DROP"
            } else {
                passed_packets += 1;
                eprintln!("Packet passed: Within threshold range");
                "PASS"
            }
        };

        eprintln!(
            "Action: {}, Avg Queue Len: {:.2}, Passed: {}, Dropped: {}",
            action, avg_queue_len, passed_packets, dropped_packets
        );

        if action == "DROP" {
            continue;
        }
    }

    Ok(())
}

pub fn handle_continuous(nic: &mut tun_tap::Iface, _ih: &InterfaceHandle) -> io::Result<()> {
    const MIN_THRESH: f64 = 1000.0;
    const MAX_THRESH: f64 = 5000.0;
    const WEIGHT: f64 = 0.002;
    const DROP_PROB_MAX: f64 = 100.0;

    let mut rng = rand::thread_rng();
    let mut avg_queue_len: f64 = 0.0;
    let mut passed_packets = 0;
    let mut dropped_packets = 0;

    let mut last_packet_time: Option<std::time::Instant> = None;

    loop {
        let mut buf = [0u8; 1504];
        let nbytes = nic.recv(&mut buf)?;

        let now = std::time::Instant::now();
        if let Some(last_time) = last_packet_time {
            let inter_packet_time = now.duration_since(last_time).as_secs_f64();
            let packet_rate = 1.0 / inter_packet_time;
            avg_queue_len = (1.0 - WEIGHT) * avg_queue_len + WEIGHT * packet_rate;
        }

        last_packet_time = Some(now);

        let current_queue_len = rng.gen_range(0.0..6000.0);

        avg_queue_len = (1.0 - WEIGHT) * avg_queue_len + WEIGHT * current_queue_len;

        let action = if avg_queue_len > MAX_THRESH {
            dropped_packets += 1;
            eprintln!("Packet dropped: Queue length exceeded MAX_THRESH");
            "DROP"
        } else if avg_queue_len < MIN_THRESH {
            passed_packets += 1;
            eprintln!("Packet passed: Queue length below MIN_THRESH");
            "PASS"
        } else {
            let drop_prob =
                ((avg_queue_len - MIN_THRESH) / (MAX_THRESH - MIN_THRESH)) * DROP_PROB_MAX;
            if rng.gen_range(0.0..100.0) < drop_prob {
                dropped_packets += 1;
                eprintln!("Packet dropped: Drop probability triggered");
                "DROP"
            } else {
                passed_packets += 1;
                eprintln!("Packet passed: Within threshold range");
                "PASS"
            }
        };

        eprintln!(
            "Action: {}, Avg Queue Len: {:.2}, Passed: {}, Dropped: {}",
            action, avg_queue_len, passed_packets, dropped_packets
        );

        if action == "DROP" {
            continue;
        }
    }

    Ok(())
}

pub fn handle_self_similar(_nic: &mut tun_tap::Iface, _ih: &InterfaceHandle) -> io::Result<()> {
    eprintln!("Self-similar traffic handling is not implemented yet.");
    Ok(())
}
