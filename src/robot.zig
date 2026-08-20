const std = @import("std");
const Allocator = std.mem.Allocator;

const joints: u8 = 2;
const links: u8 = 3;

pub const Link = struct {
    const Self = @This();

    pos: @Vector(3, f64) = .{ 0, 0, 0 },
    dir: @Vector(3, f64) = .{ 1, 0, 0 },

    length: u32 = 1,

    fn init(_pos: @Vector(3, f64), _dir: @Vector(3, f64), _length: usize) !Link {
        return .{ .pos = _pos, .dir = _dir, .length = _length };
    }
};

pub const Arm = struct {
    const Self = @This();

    movement_func: *const fn (*Arm) void = undefined,
    links: []Link = undefined,
    end_effector: @Vector(3, f64) = undefined,

    pub fn init(allocator: std.mem.Allocator, _lengths: []const usize) !Arm {
        var offset: f64 = 0;

        var _links: []Link = try allocator.alloc(Link, _lengths.len);

        for (0.._lengths.len) |idx| {
            _links[idx] = Link{ .pos = .{ offset, 0, 0 }, .dir = .{ 1, 0, 0 }, .length = @as(u32, @intCast(_lengths[idx])) };

            offset += @floatFromInt(_lengths[idx]);
        }

        return .{ .links = _links, .end_effector = .{ offset, 0, 0 } };
    }

    pub fn deinit(self: *Arm, allocator: std.mem.Allocator) void {
        allocator.free(self.links);
    }

    pub fn iter() void {}

    pub fn print(self: Self) void {
        for (self.links, 0..) |link, idx| {
            std.debug.print("Link {}:\n\tPOS: ({})\n\tDIR:({})\n\tLEN{}\n\n", .{ idx, link.pos, link.dir, link.length });
        }
    }
};

// TEST check links whether or not pos and dir undefined
// TODO: look into std.gpu
// TODO: Arm should have an async function that is called at init. This function will constantly move towards the end effector until it is at the position.
// Could do this via passing a function pointer (for cylcic or jacobian) to the init function
