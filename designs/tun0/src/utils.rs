use std::net::Ipv4Addr;

#[derive(Hash, Eq, PartialEq, Debug, Clone, Copy)]
pub struct Quad {
    pub src: (Ipv4Addr, u16),
    pub dst: (Ipv4Addr, u16),
}

// fn packet_handler_loop(mut nic: tun_tap::Iface, ih: InterfaceHandle) -> io::Result<()> {
//     let mut rng = rand::thread_rng();
//     let mut passed_packets = 0;
//     let mut dropped_packets = 0;
//
//     loop {
//         let mut buf = [0u8; 1504];
//         let nbytes = nic.recv(&mut buf)?;
//
//         if rng.gen::<u8>() % 2 == 0 {
//             passed_packets += 1;
//             eprintln!("Packet passed");
//         } else {
//             dropped_packets += 1;
//             eprintln!("Packet dropped");
//         }
//
//         eprintln!(
//             "Passed packets: {}, Dropped packets: {}",
//             passed_packets, dropped_packets
//         );
//     }
// }
