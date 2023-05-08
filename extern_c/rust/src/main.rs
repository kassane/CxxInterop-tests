use ::std::os::raw::c_char;
use std::ffi::{CStr, CString};

#[repr(C)]
// #[link_name = "cat"]
pub struct cat {
    pub name_: *const c_char,
}

extern "C" {
    pub fn make_cat(name: *const c_char) -> cat;
    pub fn cat_name(this: *const cat) -> *const c_char;
    pub fn cat_meow(this: *mut cat);
}

fn main() {
    let marshmallow_name = CString::new("Marshmallow").unwrap();

    unsafe {
        let mut marshmallow = make_cat(marshmallow_name.as_ptr());
        cat_meow(&mut marshmallow as *mut cat);
        println!("{:?}", CStr::from_ptr(cat_name(&marshmallow as *const cat)));
    }
}
