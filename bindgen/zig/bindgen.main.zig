const std = @import("std");
const cat = @import("cats.zig").cat; // local import

pub fn main() void {
    var marshmallow_name: [*:0]const u8 = "chashu";
    var marshmallow = cat.init(marshmallow_name);
    cat.meow(&marshmallow);
    cat.feed(&marshmallow);
    cat.meow(&marshmallow);
}
