const builtin = @import("builtin");

pub const cat = extern struct {
    name_: [*:0]const u8,
    is_hungry: bool,

    const ctor = @extern(*const fn (self: ?*cat, name: [*:0]const u8) callconv(.C) void, .{
        .name = switch (builtin.target.abi) {
            .msvc => "??0cat@@QEAA@PEBD@Z",
            else => "_ZN3catC1EPKc",
        },
    });
    pub inline fn init(selfname: [*:0]const u8) cat {
        var self: cat = undefined;
        ctor(&self, selfname);
        return self;
    }

    const name_m = @extern(*fn (self: ?*const cat) callconv(.C) [*:0]const u8, .{
        .name = switch (builtin.target.abi) {
            .msvc => "?name@cat@@QEBAPEBDXZ",
            else => "_ZNK3cat4nameEv",
        },
    });
    pub const name = name_m;

    const feed_m = @extern(*fn (self: ?*cat) callconv(.C) void, .{
        .name = switch (builtin.target.abi) {
            .msvc => "?feed@cat@@QEAAXXZ",
            else => "_ZN3cat4feedEv",
        },
    });
    pub const feed = feed_m;

    const meow_m = @extern(*const fn (self: ?*const cat) callconv(.C) void, .{
        .name = switch (builtin.target.abi) {
            .msvc => "?meow@cat@@QEBAXXZ",
            else => "_ZNK3cat4meowEv",
        },
    });
    pub const meow = meow_m;
};
