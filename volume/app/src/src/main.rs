use std::thread;
use std::time::Duration;

fn main() {
    println!("template-rust iniciado correctamente!");

    loop {
        println!("template-rust activo y en ejecución...");
        thread::sleep(Duration::from_secs(10));
    }
}