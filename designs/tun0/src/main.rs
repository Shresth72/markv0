use rand::Rng;
use std::net::TcpListener;
use std::sync::{
    mpsc::{self, Receiver, Sender},
    Arc, Mutex,
};
use std::{io, thread};
use tun_tap::{Iface, Mode};

struct REDParameters {
    min_thresh: f64,     // Minimum queue length threshold
    max_thresh: f64,     // Maximum queue length threshold
    weight: f64,         // Weighted average calculation factor
    max_p: f64,          // Maximum drop probability
}

impl REDParameters {
    fn new() -> Self {
        REDParameters {
            min_thresh: 100.0,
            max_thresh: 500.0,
            weight: 0.002,
            max_p: 0.1, // 10% maximum drop probability
        }
    }

    // Calculate drop probability based on average queue length
    fn calculate_drop_probability(&self, avg_queue_len: f64) -> f64 {
        if avg_queue_len < self.min_thresh {
            0.0
        } else if avg_queue_len > self.max_thresh {
            1.0
        } else {
            // Linear interpolation between min and max thresholds
            let drop_prob = self.max_p * 
                ((avg_queue_len - self.min_thresh) / 
                 (self.max_thresh - self.min_thresh));
            drop_prob
        }
    }
}

struct NetworkState {
    avg_queue_len: f64,
    total_packets: u64,
    dropped_packets: u64,
}

impl NetworkState {
    fn new() -> Self {
        NetworkState {
            avg_queue_len: 0.0,
            total_packets: 0,
            dropped_packets: 0,
        }
    }

    // Update weighted average queue length
    fn update_avg_queue_len(&mut self, current_queue_len: f64, red_params: &REDParameters) {
        self.avg_queue_len = 
            (1.0 - red_params.weight) * self.avg_queue_len + 
            red_params.weight * current_queue_len;
    }
}

fn packet_handler(
     network_state: Arc<Mutex<NetworkState>>,
    red_params: Arc<REDParameters>,
    rx: Arc<Mutex<Receiver<Vec<u8>>>>,
) {
    let mut rng = rand::thread_rng();

    loop {
        // Lock network state
        let mut state = network_state.lock().unwrap();
        
        // Simulate packet arrival
        state.total_packets += 1;
        
        // Calculate drop probability
        let drop_prob = red_params.calculate_drop_probability(state.avg_queue_len);
        
        // Decide whether to drop the packet
        let should_drop = rng.gen_range(0.0..1.0) < drop_prob;
        
        if should_drop {
            state.dropped_packets += 1;
            state.update_avg_queue_len(state.avg_queue_len + 1.0, &red_params);
            
            println!(
                "Packet dropped! Drop Probability: {:.2}%, Total Packets: {}, Dropped Packets: {}, Avg Queue Length: {:.2}",
                drop_prob * 100.0, 
                state.total_packets, 
                state.dropped_packets,
                state.avg_queue_len
            );
        } else {
            // Process the packet
            state.update_avg_queue_len(state.avg_queue_len, &red_params);
            
            // Simulate packet processing
            let rx = rx.lock().unwrap();
            if let Ok(_packet) = rx.recv() {
                println!(
                    "Packet processed. Avg Queue Length: {:.2}, Total Packets: {}, Dropped Packets: {}",
                    state.avg_queue_len, 
                    state.total_packets, 
                    state.dropped_packets
                );
            }
        }
        
        // Release the lock
        drop(state);
        
        // Small sleep to simulate time between packets
        std::thread::sleep(std::time::Duration::from_millis(50));
    }
}

fn main() -> io::Result<()> {
    let nic = Iface::without_packet_info("tun0", Mode::Tun)?;

    // Create communication channels
    let (tx, rx): (Sender<Vec<u8>>, Receiver<Vec<u8>>) = mpsc::channel();

    // Wrap state and parameters in thread-safe containers
    let network_state = Arc::new(Mutex::new(NetworkState::new()));
    let red_params = Arc::new(REDParameters::new());

    // Packet receiver thread
    thread::spawn({
        let tx = tx.clone();
        move || {
            loop {
                let mut buf = [0u8; 1504];
                if let Ok(nbytes) = nic.recv(&mut buf) {
                    tx.send(buf[..nbytes].to_vec()).unwrap();
                }
            }
        }
    });

    // Packet handler thread
    let rx = Arc::new(Mutex::new(rx));
    thread::spawn({
        let network_state = Arc::clone(&network_state);
        let red_params = Arc::clone(&red_params);
        let rx = Arc::clone(&rx);
        move || {
            packet_handler(network_state, red_params, rx);
        }
    });

    // Create TCP listener to simulate network connections
    let listener = TcpListener::bind("0.0.0.0:5000")?;
    println!("Server listening on port 5000");

    // Main thread to keep the program running
    for incoming in listener.incoming() {
        match incoming {
            Ok(_) => println!("New connection received"),
            Err(e) => eprintln!("Error accepting connection: {}", e),
        }
    }

    Ok(())
}
