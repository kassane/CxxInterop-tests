# Set the current directory
$CurrentDir = Get-Location

# Zig
zig build -Doptimize=ReleaseFast --summary all
zig build bindgen -Doptimize=ReleaseFast
zig build extern_c -Doptimize=ReleaseFast

# D
cd "$CurrentDir/extern_c/d"
dub --build=release
cd $CurrentDir

cd "$CurrentDir/bindgen/d"
dub --build=release
cd $CurrentDir

# Swift
cd "$CurrentDir/extern_c/swift"
cmake -B build -DCMAKE_BUILD_TYPE=Release
cmake --build build --config release --target run
cd $CurrentDir

cd "$CurrentDir/bindgen/swift"
cmake -B build -DCMAKE_BUILD_TYPE=Release
cmake --build build  --config release --target run
cd $CurrentDir

# Rust
cargo build -q --release
cargo run --release --bin cats_bindgen
cargo run --release --bin cats_cxx
cargo run --release --bin cats_extern_c