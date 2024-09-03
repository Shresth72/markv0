use crate::InterfaceHandle;

pub struct Connection {}

pub struct TcpListener {
    pub port: u16,
    pub ih: InterfaceHandle,
}
