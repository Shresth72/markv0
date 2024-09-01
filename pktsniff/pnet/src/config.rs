use notify_rust::Notification;
use serde::Deserialize;

#[derive(Deserialize)]
pub struct Config {
    pub general: GeneralConfig,
    pub alert: AlertConfig,
}

#[derive(Deserialize)]
pub struct GeneralConfig {
    pub mode: String,
}

#[derive(Deserialize)]
pub struct AlertConfig {
    pub ip: String,
    pub port: u16,
}

pub fn send_alert(ip: &str, port: u16) {
    println!("ALERT! Traffic from IP {} on port {}", ip, port);

    Notification::new()
        .summary("Network Monitoring Alert")
        .body(&format!("Traffic from IP {} on port {}", ip, port))
        .show()
        .unwrap();
}
