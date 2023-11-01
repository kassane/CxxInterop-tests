use cmake;
#[cfg(target_os = "windows")]
use std::env;

#[cfg(target_os = "windows")]
fn get_target() -> String {
    if cfg!(windows) && std::env::var("CXXFLAGS").is_err() {
        "release".to_string()
    } else {
        env::var("PROFILE").unwrap()
    }
}

fn main() {
    // Tell cargo to invalidate the built crate whenever the header changes
    println!("cargo:rerun-if-changed=../cpp/cats.hpp");
    println!("cargo:rerun-if-changed=../cpp/cats.cpp");

    // Builds the project in the directory located in `../cpp`, installing it
    // into $OUT_DIR
    let dst = cmake::Config::new("../cpp")
        // .generator("Visual Studio 17 2022")
        .cxxflag("-std=c++20")
        .build();

    println!("cargo:rustc-link-search=native={}", dst.display());
    println!("cargo:rustc-link-lib=static=cats");
    #[cfg(target_os = "linux")]
    println!("cargo:rustc-link-lib=dylib=stdc++");
    #[cfg(target_os = "macos")]
    println!("cargo:rustc-link-lib=dylib=c++");
    #[cfg(target_os = "windows")]
    if get_target() == "debug" {
        println!("cargo:rustc-link-lib=dylib=msvcrtd");
    } else {
        println!("cargo:rustc-link-lib=dylib=msvcrt");
    }
}
