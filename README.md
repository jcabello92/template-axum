# Plantilla Docker - Rust (Backend)

Plantilla minimalista y multipropósito para Rust en Docker. No incluye frameworks, ORMs ni transportes predefinidos.

## Requisitos previos

Crear la red externa de Docker definida en `.env` (si aún no existe):

```bash
docker network create template-network
```

## Uso en desarrollo

1. Iniciar los contenedores:
   ```bash
   docker compose up -d
   ```

2. Inicializar el proyecto de Rust (si aún no está creado):
   ```bash
   docker compose exec app cargo init . --name <nombre-del-proyecto>
   ```

3. El contenedor detectará `Cargo.toml` y activará el hot-reload mediante **cargo-watch**.

## Uso en producción

Compilar y levantar en modo producción (binario optimizado en Alpine):

```bash
docker compose -f docker-compose.prod.yml up -d --build
```
