FROM debian:bullseye

ENV WASI_VERSION=20
ENV WASI_VERSION_FULL=${WASI_VERSION}.0
ENV WASI_SYSROOT=/opt/wasi-sdk-${WASI_VERSION_FULL}/share/wasi-sysroot/
ENV WASMER_DIR=/opt/wasmer
ENV PATH="${PATH}:/opt/wasi-sdk-${WASI_VERSION_FULL}/bin:/root/.nimble/bin:${WASMER_DIR}/bin:/opt/wabt/bin"
ENV LD_LIBRARY_PATH="${WASMER_DIR}/lib/:${LD_LIBRARY_PATH}"

WORKDIR /cart

ADD https://github.com/WebAssembly/wasi-sdk/releases/download/wasi-sdk-${WASI_VERSION}/wasi-sdk-${WASI_VERSION_FULL}-linux.tar.gz /opt/wasi-sdk-${WASI_VERSION_FULL}-linux.tar.gz
ADD https://github.com/dryzig/zig-debian/releases/download/0.6.0-1/zig_0.6.0-1_amd64.deb /tmp/zig_0.6.0-1_amd64.deb
ADD https://nim-lang.org/choosenim/init.sh /tmp/install_nim.sh
ADD https://sh.rustup.rs /tmp/install_rust.sh
ADD https://deb.nodesource.com/setup_20.x /tmp/install_node.sh
ADD https://github.com/wasmerio/wasmer/releases/download/v4.0.0-alpha.1/wasmer-linux-amd64.tar.gz /tmp/wasmer.tgz

RUN apt-get update && \
  apt-get install -y wabt binaryen curl make cmake xz-utils zip && \
  cd /opt && \
  tar xvf wasi-sdk-${WASI_VERSION_FULL}-linux.tar.gz && \
  dpkg -i /tmp/zig_0.6.0-1_amd64.deb && \
  mkdir $WASMER_DIR /opt/wabt && \
  tar xzf /tmp/wasmer.tgz -C $WASMER_DIR && \
  chmod 755 /tmp/install_nim.sh /tmp/install_rust.sh /tmp/install_node.sh && \
  /tmp/install_nim.sh -y && \
  /tmp/install_rust.sh -y && \
  /tmp/install_node.sh && \
  apt-get install -y nodejs && \
  npm i -g assemblyscript && \
  rm /tmp/zig_0.6.0-1_amd64.deb && \
  rm /opt/wasi-sdk-${WASI_VERSION_FULL}-linux.tar.gz && \
  rm /tmp/install_node.sh && \
  rm /tmp/install_rust.sh && \
  rm /tmp/install_nim.sh && \
  rm /tmp/wasmer.tgz