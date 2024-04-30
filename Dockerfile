FROM rust:alpine as builder

RUN apk add --no-cache build-base openssl-dev openssl-libs-static

WORKDIR /app/x8
COPY Cargo.toml Cargo.lock ./
COPY src/ src/

RUN cargo build --release

FROM alpine:3.17.1
COPY --from=builder /app/x8/target/release/x8 /usr/local/bin/x8
ENTRYPOINT [ "x8" ]
