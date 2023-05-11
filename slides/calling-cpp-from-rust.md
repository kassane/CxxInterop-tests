# Calling C++ from Rust
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
- Binding C++ and Rust
    - The low-level way
    - An intermediate way
    - A high-level way

---

# What is Rust?

- First created in 2005
- 1.0 released in 2015
- Incubated at Mozilla Research
- Designed to enable Firefox to build a parallel rendering engine

---

# What is Rust?

- ML-inspired, but with a C-like syntax
- Memory-safety without runtime costs (e.g. no GC)
- Native C interop
- Zero-cost abstractions
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
    name: String  // <- name-first struct fields, like e.g. TypeScript
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

# Binding C++ and Rust: the low-level way

- Export C++ code using `extern "C"`
- Import the C++ code from Rust using `extern "C"`
- Maximum flexibility
- Labor-intensive

---

# Binding C++ and Rust: the mid-level way

- Use the Rust `bindgen` library to read `.hpp` files
- It works with a lot of things, such as templates without specialization
- Auto-generates `extern "C"` Rust imports (no high-level library mappings)
- In reverse: `cbindgen`

---

# Binding C++ and Rust: the high-level way

- Using the Rust `cxx` library
- Manually define Rust/C++ interfaces
- Automatic binding of library types
- More automated: `autocxx` (no demo here)
- Async support: `cxx-async` (no demo here)

---

# Conclusion

- Rust is a memory-safe systems programming language
- It has native interop with C
- Different strategies you can use to interop Rust and C++
- What the right approach for you is will depend on your project
- Work is actively ongoing to make it easier to bind the two

---

# Thank you

## https://github.com/yoshuawuyts/rustcpp
