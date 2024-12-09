#![allow(unused)]
mod tcp;
mod udp;
mod utils;

use rand::Rng;
use tcp::*;
use utils::Quad;

use std::{
    collections::{hash_map::Entry, HashMap, VecDeque},
    error::Error,
    io,
    sync::{Arc, Mutex},
    thread,
};

pub enum TrafficType {
    EarlyBurst,
    Continuous,
    SelfSimilar,
}

impl Default for TrafficType {
    fn default() -> Self {
        TrafficType::EarlyBurst
    }
}

#[derive(Default)]
pub struct CondvarMutex {
    manager: Mutex<ConnectionManager>,
}

type InterfaceHandle = Arc<CondvarMutex>;

pub struct Interface {
    pub ih: Option<InterfaceHandle>,
    pub jh: Option<thread::JoinHandle<io::Result<()>>>,
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
                packet_handler_loop(nic, ih, TrafficType::default())
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

pub fn packet_handler_loop(
    mut nic: tun_tap::Iface,
    ih: InterfaceHandle,
    traffic_type: TrafficType,
) -> io::Result<()> {
    match traffic_type {
        TrafficType::EarlyBurst => handle_early_burst(&mut nic, &ih),
        TrafficType::Continuous => handle_continuous(&mut nic, &ih),
        TrafficType::SelfSimilar => handle_self_similar(&mut nic, &ih),
    }
}
