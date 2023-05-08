use cmake;

fn main() {
    // Tell cargo to invalidate the built crate whenever the header changes
    println!("cargo:rerun-if-changed=../cpp/cats.hpp");

    // Builds the project in the directory located in `../cpp`, installing it
    // into $OUT_DIR
    let dst = cmake::Config::new("../cpp")
        // .generator("Visual Studio 17 2022")
        .build();

    println!("cargo:rustc-link-search=native={}", dst.display());
    println!("cargo:rustc-link-lib=static=cats");
    println!("cargo:rustc-link-lib=dylib=c++");
}
