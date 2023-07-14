const std = @import("std");
const cat = @import("cats.zig").cat; // local import

pub fn main() void {
    var chashu_name: [*:0]const u8 = "chashu";
    var chashu = cat.init(chashu_name);
    std.debug.print("Our cat is: {s}\n", .{chashu_name});
    cat.meow(&chashu);
    cat.feed(&chashu);
    cat.meow(&chashu);
}
