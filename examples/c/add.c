// this shows basic & minimal WASM works

// clang --target=wasm32 --no-standard-libraries -Wl,--export-all -Wl,--no-entry -o add.wasm examples/c/add.c

int add (int first, int second) {
  return first + second;
}
