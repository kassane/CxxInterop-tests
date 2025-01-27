const std = @import("std");
const cats = @import("cats.zig"); // local import

pub fn main() void {
    std.debug.print("Zig language - extern C\n", .{});
    const marshmallow_name: cats.c_str = "Marshmallow";
    var marshmallow = cats.make_cat(marshmallow_name);
    std.debug.print("Our cat is: {s}\n", .{cats.cat_name(&marshmallow)});
    cats.cat_meow(&marshmallow);
    cats.cat_feed(&marshmallow);
    cats.cat_meow(&marshmallow);
}
