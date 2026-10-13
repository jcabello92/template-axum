# --- FASE 1: BASE ---
FROM rust:alpine3.24 AS base
WORKDIR /app
RUN apk add --no-cache musl-dev gcc build-base

# --- FASE 2: DESARROLLO (dev) ---
FROM base AS dev
RUN cargo install cargo-watch
CMD ["sh", "-c", "if [ -f Cargo.toml ]; then cargo watch -x run; else echo 'Proyecto no inicializado. Manteniendo contenedor vivo...' && tail -f /dev/null; fi"]

# --- FASE 3: CONSTRUCCIÓN (build) ---
FROM base AS build
COPY ./volume/app/src .
RUN echo 'fn main() { println!("Plantilla Rust"); loop { std::thread::sleep(std::time::Duration::from_secs(86400)); } }' > dummy.rs && rustc dummy.rs -o /app/app
RUN if [ -f Cargo.toml ]; then cargo install --path . --root /app && mv /app/bin/* /app/app; fi

# --- FASE 4: PRODUCCIÓN (prod) ---
FROM alpine:latest AS prod
WORKDIR /app
COPY --from=build /app/app ./app
CMD ["./app"]