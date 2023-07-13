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

fn main() {
    let marshmallow_name = CString::new("Marshmallow").unwrap();

    unsafe {
        let mut marshmallow = make_cat(marshmallow_name.as_ptr());
        println!(
            "Our cat is: {:?}",
            CStr::from_ptr(cat_name(&marshmallow as *const cat))
        );
        cat_meow(&marshmallow as *const cat);
        cat_feed(&mut marshmallow as *mut cat);
        cat_meow(&marshmallow as *const cat);
    }
}
