const std = @import("std");
const Allocator = std.mem.Allocator;

const joints: u8 = 2;
const links: u8 = 3;

pub const Link = struct {
    var pos: @Vector(3, f64) = undefined;
    var dir: @Vector(3, f64) = undefined;

    var length: u32 = 1;

    fn init(_pos: @Vector(3, f64), _dir: @Vector(3, f64), _length: usize) !Link {
        pos = _pos;
        dir = _dir;
        length = _length;
    }
};

pub const Arm = struct {
    const links: Link;
};

// TEST check links whether or not pos and dir undefined
