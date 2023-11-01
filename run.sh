#!/usr/bin/bash

CURRENT_DIR=$PWD

rm -fr build target zig-*

# Zig
zig build -Doptimize=ReleaseFast --summary all
zig build bindgen -Doptimize=ReleaseFast && zig build extern_c -Doptimize=ReleaseFast

# D
cd extern_c/d
rm -fr build
dub --build=release
cd $CURRENT_DIR
cd bindgen/d
rm -fr build
dub --build=release
cd $CURRENT_DIR

# Swift
cd "$CURRENT_DIR/extern_c/swift"
rm -fr build .build
cmake -GNinja -B build -DCMAKE_BUILD_TYPE=Release
cmake --build build --target run
cd $CURRENT_DIR

cd "$CURRENT_DIR/bindgen/swift"
rm -fr build .build
cmake -GNinja -B build -DCMAKE_BUILD_TYPE=Release
cmake --build build --target run
cd $CURRENT_DIR

# Rust
cargo build -q --release
cargo run --release --bin cats_bindgen
cargo run --release --bin  cats_cxx
cargo run --release --bin cats_extern_c
