# Hello

- Yosh
- Rust Developer Advocate @ Microsoft
- Mastodon: toot.yosh.is/@yosh

---

# In this talk

- A brief introduction to what Rust is
- A whirlwind tour of Rust
- Binding C++ and Rust
    - The low-level way
    - An intermediate way
    - A high-level way

---

# What is Rust?

Think of it as: "Systems ML"

- ML-inspired, but with a C-like syntax
- Designed for systems programming
- Memory safe without runtime costs
- Native C interop (LLVM-based codegen)
- Zero-cost abstractions
- Advanced async IO facilities

---

# Projects using Rust

If you're browsing a website today, it's likely your request is being handled by
Rust code somewhere along the way.

- OS Kernels: Linux, Windows, Android
- Browsers: Firefox, Chrome
- Cloud Operators: Azure, AWS, Fastly, CloudFlare

---

# Rust crash course

## The Rust ownership model

You can think of every value in Rust as being wrapped in a mutex which is
validated at compile-time. Every value in Rust can be passed in one of three
ways:

1. Owned (`value`), the value is moved and can be read + mutated freely
1. Unique reference (`&mut value`), the referenced value can be read + mutated
2. Shared reference (`&value`), the referenced value can only be read

This is zero-cost, cannot be disabled, and is how Rust provides memory-safety
without a runtime cost.

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
    fn name(&self) -> &str {
        &self.name // <- expression-oriented return, like e.g. Ruby
    }

    fn set_name(&mut self, name: String) {
        self.name = name;
    }
}
```
