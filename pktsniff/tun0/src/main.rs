use std::{
    io::{self, Read},
    thread,
};

use tun0::Interface;

fn main() -> io::Result<()> {
    let mut interface = Interface::new()?;
    let listener = interface.bind_tcp(6969)?;
    println!("bound to port 6969");

    while let Ok((mut stream, addr)) = listener.accept() {
        println!("got connection from {:?}", addr);

        thread::spawn(move || {
            let mut buffer = [0; 512];
            loop {
                match stream.read(&mut buffer) {
                    Ok(0) => break,
                    Ok(s) => {
                        println!("read: {}", s);
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
