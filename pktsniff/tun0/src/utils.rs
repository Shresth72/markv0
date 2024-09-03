use std::net::Ipv4Addr;

#[derive(Hash, Eq, PartialEq, Debug, Clone, Copy)]
pub struct Quad {
    pub src: (Ipv4Addr, u16),
    pub dst: (Ipv4Addr, u16),
}
