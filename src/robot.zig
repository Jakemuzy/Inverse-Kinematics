const std = @import("std");
const Allocator = std.mem.Allocator;

const joints: u8 = 2;
const links: u8 = 3;

pub const Link = struct {
    pos: @Vector(3, f64) = .{ 0, 0, 0 },
    dir: @Vector(3, f64) = .{ 1, 0, 0 },

    length: u32 = 1,

    fn init(_pos: @Vector(3, f64), _dir: @Vector(3, f64), _length: usize) !Link {
        return .{ .pos = _pos, .dir = _dir, .length = _length };
    }
};

pub const Arm = struct {
    const Self = @This();

    // Could remove dir and length since already default init
    links: []const Link = &.{
        Link{ .pos = .{ 0, 0, 0 }, .dir = .{ 1, 0, 0 }, .length = 1 },
        Link{ .pos = .{ 1, 0, 0 }, .dir = .{ 1, 0, 0 }, .length = 1 },
        Link{ .pos = .{ 2, 0, 0 }, .dir = .{ 1, 0, 0 }, .length = 1 },
    },

    fn init() void {}

    fn deinit() void {}

    fn iter() void {}

    pub fn print(self: Self) void {
        std.debug.print("Link 1:\n\tPOS: ({})\n\tDIR:({})\n\tLENGTH: {}\n\n", .{ self.links[0].pos, self.links[0].dir, self.links[0].length });
        std.debug.print("Link 2:\n\tPOS: ({})\n\tDIR:({})\n\tLENGTH: {}\n\n", .{ self.links[1].pos, self.links[1].dir, self.links[1].length });
        std.debug.print("Link 3:\n\tPOS: ({})\n\tDIR:({})\n\tLENGTH: {}\n\n", .{ self.links[2].pos, self.links[2].dir, self.links[2].length });
    }
};

// TEST check links whether or not pos and dir undefined
// TODO: look into std.gpu
