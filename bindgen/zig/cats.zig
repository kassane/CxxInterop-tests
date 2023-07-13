pub const cat = extern struct {
    name_: [*:0]const u8,
    is_hungry: bool,

    extern fn @"_ZN3catC1EPKc"(self: ?*cat, name: [*:0]const u8) void;
    pub inline fn init(selfname: [*:0]const u8) cat {
        var self: cat = undefined;
        @"_ZN3catC1EPKc"(&self, selfname);
        return self;
    }

    extern fn @"_ZNK3cat4nameEv"(self: ?*const cat) [*:0]const u8;
    pub const name = @"_ZNK3cat4nameEv";

    extern fn @"_ZN3cat4feedEv"(self: ?*cat) void;
    pub const feed = @"_ZN3cat4feedEv";

    extern fn @"_ZNK3cat4meowEv"(self: ?*const cat) void;
    pub const meow = @"_ZNK3cat4meowEv";
};
