FROM library/rust:1.57.0-slim as BUILD

WORKDIR /opt/shakshuka

COPY . .

RUN rustup target add x86_64-unknown-linux-musl

RUN cargo build --target=x86_64-unknown-linux-musl --release

FROM alpine as DEBUG

WORKDIR /opt/shakshuka

COPY --from=BUILD /opt/shakshuka/target/x86_64-unknown-linux-musl/release/shk ./shk

ENTRYPOINT ["./shk"]

FROM scratch

COPY --from=BUILD /opt/shakshuka/target/x86_64-unknown-linux-musl/release/shk /

ENTRYPOINT ["/shk"]
