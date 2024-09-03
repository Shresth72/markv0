use std::{
    io,
    net::{SocketAddr, TcpListener as StdTcpListener, TcpStream},
};

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
