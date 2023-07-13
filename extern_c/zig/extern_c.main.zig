const std = @import("std");
const cats = @import("cats.zig"); // local import

pub fn main() void {
    var marshmallow_name: cats.c_str = "Marshmallow";
    var marshmallow = cats.make_cat(marshmallow_name);
    cats.cat_meow(&marshmallow);
    cats.cat_feed(&marshmallow);
    cats.cat_meow(&marshmallow);
}
