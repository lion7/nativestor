# Build the manager binaryFROM golang:1.13 as builder

FROM golang:1.19 AS builder
ARG NATIVE_STOR_VERSION
COPY . /workdir
WORKDIR /workdir
RUN make build NATIVE_STOR_VERSION=${NATIVE_STOR_VERSION}

FROM ubuntu:22.04
RUN apt-get update && apt-get -y install gdisk udev
COPY --from=builder /workdir/bin/topolvm /topolvm
ENTRYPOINT ["/topolvm"]
