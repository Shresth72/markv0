use std::{
    io::{self, Read},
    thread,
};

use tun0::Interface;

fn main() -> io::Result<()> {
    let mut interface = Interface::new()?;
    let listener = interface.bind_tcp(6969)?;
    eprintln!("bound to port 8080");

    while let Ok((mut stream, addr)) = listener.accept() {
        eprintln!("got connection from {:?}", addr);

        thread::spawn(move || {
            // Handle the connection, e.g., read/write to the stream
            let mut buffer = [0; 512];
            loop {
                match stream.read(&mut buffer) {
                    Ok(0) => break, // Connection closed
                    Ok(_) => {
                        // Process packet (here you can implement your logic)
                    }
                    Err(e) => {
                        eprintln!("Error reading stream: {}", e);
                        break;
                    }
                }
            }
        });
    }

    Ok(())
}
