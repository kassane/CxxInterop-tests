include!(concat!(env!("OUT_DIR"), "/bindings.rs"));

use std::ffi::{CStr, CString};

fn main() {
    let marshmallow_name = CString::new("Marshmallow").unwrap();

    unsafe {
        let mut marshmallow = cat::new(marshmallow_name.as_ptr());
        marshmallow.meow();
        println!("{:?}", CStr::from_ptr(marshmallow.name()));
    }
}
