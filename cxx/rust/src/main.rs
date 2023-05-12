#[cxx::bridge]
mod ffi {
    struct Cat {
        name_: String,
        is_hungry: bool,
    }

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

fn new_cat(name: &str) -> ffi::Cat {
    ffi::Cat {
        name_: name.to_owned(),
        is_hungry: true,
    }
}

impl ffi::Cat {
    fn meow(&self) {
        if self.is_hungry {
            println!("{} is hungry", self.name_);
        } else {
            println!("{} is sleepy", self.name_);
        }
    }

    fn feed(&mut self) {
        self.is_hungry = false;
    }

    fn name(&self) -> &str {
        &self.name_
    }
}

fn main() {
    ffi::test();
}
