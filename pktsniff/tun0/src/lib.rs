#![allow(unused)]
mod tcp;
mod udp;
mod utils;

use rand::Rng;
use tcp::TcpListener;
use udp::UdpListener;
use utils::Quad;

use std::{
    collections::{hash_map::Entry, HashMap, VecDeque},
    io,
    sync::{Arc, Mutex},
    thread,
};

#[derive(Default)]
pub struct CondvarMutex {
    manager: Mutex<ConnectionManager>,
}

type InterfaceHandle = Arc<CondvarMutex>;

pub struct Interface {
    ih: Option<InterfaceHandle>,
    jh: Option<thread::JoinHandle<io::Result<()>>>,
}

#[derive(Default)]
struct ConnectionManager {
    terminate: bool,
    tcp_connections: HashMap<Quad, tcp::Connection>,
    udp_connections: HashMap<Quad, udp::Connection>,
    pending: HashMap<u16, VecDeque<Quad>>, // Port, Quad Vector
}

// Interface
impl Interface {
    pub fn new() -> io::Result<Self> {
        let nic = tun_tap::Iface::without_packet_info("tun0", tun_tap::Mode::Tun)?;
        let ih: InterfaceHandle = Arc::default();

        let jh = {
            let ih = ih.clone();
            thread::spawn(move || {
                // Handle Connection
                packet_handler_loop(nic, ih)
            })
        };

        Ok(Interface {
            ih: Some(ih),
            jh: Some(jh),
        })
    }

    pub fn bind_tcp(&mut self, port: u16) -> io::Result<TcpListener> {
        let mut cm = self.ih.as_mut().unwrap().manager.lock().unwrap();

        match cm.pending.entry(port) {
            Entry::Vacant(v) => {
                v.insert(VecDeque::new());
            }
            Entry::Occupied(_) => {
                return Err(io::Error::new(
                    io::ErrorKind::AddrInUse,
                    "port already bound",
                ));
            }
        };

        drop(cm);
        Ok(TcpListener {
            port,
            ih: self.ih.as_mut().unwrap().clone(),
        })
    }
}

fn packet_handler_loop(mut nic: tun_tap::Iface, ih: InterfaceHandle) -> io::Result<()> {
    let mut rng = rand::thread_rng();
    let mut passed_packets = 0;
    let mut dropped_packets = 0;

    loop {
        let mut buf = [0u8; 1504];
        let nbytes = nic.recv(&mut buf)?;

        if rng.gen::<u8>() % 2 == 0 {
            passed_packets += 1;
            eprintln!("Packet passed");
        } else {
            dropped_packets += 1;
            eprintln!("Packet dropped");
        }

        eprintln!(
            "Passed packets: {}, Dropped packets: {}",
            passed_packets, dropped_packets
        );
    }
}
