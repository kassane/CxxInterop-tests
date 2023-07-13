pub const cat = extern struct {
    name_: c_str,
    is_hungry: bool,
};
pub const c_str = [*:0]const u8;

pub extern fn make_cat(name: c_str) cat;
pub extern fn cat_name(c: ?*const cat) c_str;
pub extern fn cat_feed(c: ?*cat) void;
pub extern fn cat_meow(c: ?*const cat) void;

// ?* optional poiter, like std::optional<> (null[opt] or value.*)
