use axum::{routing::get, Router};
use tokio::net::TcpListener;

#[tokio::main]
async fn main() {
    let app = Router::new().route("/health", get(|| async { "ok" }));

    let listener = TcpListener::bind("127.0.0.1:3000").await.unwrap();
    println!("backend listening on http://{}", listener.local_addr().unwrap());
    axum::serve(listener, app).await.unwrap();
}
