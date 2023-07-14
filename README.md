This is some experiments with very light WASM/WASI.

It will also eventually be the main build environment for null0 games.

Initially, I followed article [here](https://depth-first.com/articles/2019/10/16/compiling-c-to-webassembly-and-running-it-without-emscripten/).

Building & using this container locally:

```sh
docker build -t null0 .
docker run -it --rm -v $(pwd):/cart null0
```

You can also do this to use the remote container that is already built for you:

```
docker run -it --rm -v $(pwd):/cart konsumer/null0
```

I've only tested/built on amd64, and you will probably have issues on arm64.

This will give you wasmer/clang/llvm/wasm-sdk/nim/zig/make/cmake/gcc/rust/nodejs/assemblyscript/binaryen/wabt for building and working with carts.

I have left out emscripten, since we are going for very light wasm, without a lot of host-dependencies, and it can create some conflicts with the llvm-focused setup. I should look into this, especially ideas in [this](https://github.com/emscripten-core/emscripten/wiki/WebAssembly-Standalone) which will essentiually create similar light builds, but allow you to see & tune the JS.
