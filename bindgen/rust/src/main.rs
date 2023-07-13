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
