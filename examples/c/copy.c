// this shows WASM libc/stdlib (sysroot) is working

// clang --target=wasm32-unknown-wasi --sysroot $WASI_SYSROOT -nostartfiles -Wl,--import-memory -Wl,--no-entry -Wl,--export-all -o copy.wasm examples/c/copy.c

#include <string.h>

int copy(char *input, char *output) {
    const int length = strlen(input);

    strncpy(output, input, length);

    return length;
}