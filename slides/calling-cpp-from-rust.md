# Bridging C++ and Rust
## Yosh Wuyts, Microsoft

---
# Hello

- Yosh Wuyts
- Rust Developer Advocate @ Microsoft
- C++ novice
- Rust Programmer since 2017
- Rust Async WG Member

---

# In this talk

- What and Why of Rust
- A whirlwind tour of Rust
- Bridging C++ and Rust
    - The low-level, manual way
    - An more automated way
    - A high-level way

---

# What is Rust?

- First created in 2005
- 1.0 released in 2015
- Incubated at Mozilla Research
- Designed to enable Firefox to build a parallel rendering engine

---

# What is Rust?

- Hindley-Milner type system, but with a C-like syntax
- Memory-safety without runtime costs (no GC, no auto-refcounting)
- Native C interop
- Zero-cost abstractions and no hidden boxing
- Advanced async IO facilities

You can think of Rust as "Systems ML"

---

# Projects using Rust

- OS Kernels: Linux, Windows, Android
- Browsers: Firefox, Chrome
- Cloud Operators: Azure, AWS, Fastly, CloudFlare

If you're browsing any website today, it's likely your request is being handled by Rust code somewhere along the way.

---

# Rust crash course
## Syntax

- `fn` to declare functions
- `-> Cat` for return types in signatures
- `name: String` name + type pairs
- `impl Cat {}` to implement methods on the type `Cat`

---

# Rust crash course

## The Rust ownership model

1. Owned/moved (`value`): read + mutate
1. Unique reference (`&mut value`): read + mutate
2. Shared reference (`&value`): read-only

Mental model: every reference in Rust is wrapped in a Read-Write lock which only exists at compile-time.

---

# Rust crash course

## Struct Declarations

```rust
struct Cat {
    name: String  // name: Type
}
```

---

# Rust crash course

## Free functions

```rust
fn meow() {  // <- zero-sized return type is implied
    println!("meow");
}
```

---

# Rust crash course

## Class methods ("inherent methods")

```rust
impl Cat {
    fn name(&self) -> &str {  // <- shared access
        &self.name // <- expression-oriented return, like e.g. Ruby
    }

    fn set_name(&mut self, name: String) { // <- unique access
        self.name = name; // <- mutating a value!
    }
}
```

---

# Bridging C++ and Rust: entirely by hand

- Export C++ code using `extern "C"`
- Import the C++ code from Rust using `extern "C"`
- Maximum flexibility
- Labor-intensive

---

# `cpp/cats.hpp`

```cpp
#include <string>
#include <iostream>

struct cat {
    const char *name_;
    bool is_hungry;
};

extern "C" {
    cat make_cat(const char *name);
    const char *cat_name(const cat *c);
    void cat_feed(cat *c);
    void cat_meow(const cat *c);
}
```

---

# `cpp/cats.cpp`

```cpp
#include "cats.hpp"

cat make_cat(const char *name) {
    cat c{name, true};
    return c;
}
const char *cat_name(const cat *c) { return c->name_; }
void cat_feed(cat *c) { c->is_hungry = false; }
void cat_meow(const cat *c) {
    if (c->is_hungry) { std::cout << c->name_ << " is hungry\n"; }
    else { std::cout << c->name_ << " is sleepy\n"; }
}
```

---

# `rust/build.rs`

```rust
let dst = cmake::Config::new("../cpp")
    .cxxflag("-std=c++20")
    .build();
```

---

# `rust/src/main.rs`

```rust
use ::std::os::raw::c_char;
use std::ffi::{CStr, CString};

#[repr(C)]
pub struct cat {
    pub name_: *const c_char,
    pub is_sleepy: bool,
}

extern "C" {
    pub fn make_cat(name: *const c_char) -> cat;
    pub fn cat_name(this: *const cat) -> *const c_char;
    pub fn cat_feed(this: *mut cat);
    pub fn cat_meow(this: *const cat);
}
```

---

# `rust/src/main.rs`

```rust
fn main() {
    let marshmallow_name = CString::new("Marshmallow").unwrap();
    unsafe {
        let mut marshmallow = make_cat(marshmallow_name.as_ptr());
        let s = CStr::from_ptr(cat_name(&marshmallow as *const cat));
        println!("Our cat is: {s:?}");
        cat_meow(&marshmallow as *const cat);
        cat_feed(&mut marshmallow as *mut cat);
        cat_meow(&marshmallow as *const cat);
    }
}
```

---

# Bridging C++ and Rust: with some automation

- Use the Rust `bindgen` library to read `.hpp` files
- It works with a lot of things, such as templates without specialization
- Auto-generates `extern "C"` Rust imports (no high-level library mappings)
- In reverse: `cbindgen`


---

# `cpp/cats.hpp`

```cpp
#include <string>
#include <iostream>

class cat
{
public:
    cat(const char *name);
    const char *name() const;
    void feed();
    void meow() const;

private:
    const char *name_;
    bool is_hungry;
};
```

---

# `cpp/cats.cpp`

```cpp
#include "cats.hpp"

cat::cat(const char *name) : name_(name), is_hungry(true) {}
const char *cat::name() const { return name_; }
void cat::feed() { is_hungry = false; }
void cat::meow() const {
    if (is_hungry) { std::cout << name_ << " is hungry\n"; }
    else { std::cout << name_ << " is sleepy\n"; }
}
```

---

# `rust/build.rs`

```rust
let bindings = bindgen::Builder::default()
    .clang_arg("-std=c++20")
    /* more args here */
    .generate()
    .unwrap();
bindings.write_to_file(out_path.join("bindings.rs")).unwrap();

let dst = cmake::Config::new("../cpp")
    .cxxflag("-std=c++20")
    .build();
```

---

# `rust/src/main.rs`

```rust
include!(concat!(env!("OUT_DIR"), "/bindings.rs"));
use std::ffi::{CStr, CString};

fn main() {
    let chashu_name = CString::new("chashu").unwrap();
    unsafe {
        let mut chashu = cat::new(chashu_name.as_ptr());
        println!("Our cat is: {:?}", CStr::from_ptr(chashu.name()));
        chashu.meow();
        chashu.feed();
        chashu.meow();
    }
}
```

---

# Bridging C++ and Rust: with high-level types

- Roundtrip example: Rust -> C++ -> Rust 
- Using the Rust `cxx` library
- Manually define Rust/C++ interfaces
- Automatic bridging of library types

---

# `cpp/cats.hpp`

```cpp
void test();
```

---

# `cpp/cats.cpp`

```cpp
#include "../../target/cxxbridge/cats_cxx/src/main.rs.h"
#include <iostream>
void test() {
    Cat nori = make("Nori");
    std::cout << "Our cat's name is " << std::string(nori.name()) << "\n";
    nori.meow();
    nori.feed();
    nori.meow();
}
```

---

# `rust/build.rs`

```rust
cxx_build::bridge("src/main.rs")
    .flag_if_supported("-std=c++20")
    .file("../cpp/cats.cpp")
    .compile("cats");
```

---

# `rust/src/main.rs`

```rust
#[cxx::bridge]
mod ffi {
    struct Cat { name_: String, is_hungry: bool, }
    extern "Rust" {
        #[cxx_name = "make"]
        fn new_cat(name: &str) -> Cat;
        fn meow(self: &Cat);
        fn feed(self: &mut Cat);
        fn name(self: &Cat) -> &str;
    }
    unsafe extern "C++" {
        include!("cats_cxx/../cpp/cats.hpp");
        fn test();
    }
}
```

---

# `rust/src/main.rs`

```rust
fn new_cat(name: &str) -> ffi::Cat {
    ffi::Cat { name_: name.to_owned(), is_hungry: true, }
}

impl ffi::Cat {
    fn feed(&mut self) { self.is_hungry = false; }
    fn name(&self) -> &str { &self.name_ }
    fn meow(&self) {
        if self.is_hungry { println!("{} is hungry", self.name_); }
        else { println!("{} is sleepy", self.name_); }
    }
}
```

---

# `rust/src/main.rs`

```rust
fn main() {
    ffi::test();
}
```

---

# Even More Options

- `cxx` can use types generated by `bindgen` to make it less manual
- Google's `autocxx` project can automate this process
- `cxx-async` enables bridging async (Folly, etc.) types 
- `cbindgen` easily export Rust types as C headers + types

---


# Conclusion

- Rust is a memory-safe systems programming language
- Native interop with C
- Different strategies you can use to interop Rust and C++
- What the right approach for you is will depend on your project
- Work is actively ongoing to make it easier to bind the two

---

# Thank you

## https://github.com/yoshuawuyts/rustcpp
