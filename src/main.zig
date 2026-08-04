const std = @import("std");
const expect = std.testing.expect;
const Allocator = std.mem.Allocator;

const steps: u16 = 7200;
const angle_differential: f32 = 360 / steps;

pub fn main() void {
    const joints: i8 = 4;
    const links: i8 = 5;

    _ = joints;
    _ = links;

    const jacobian = jacobianMatrix(3);
    _ = jacobian;

    std.debug.print("Hello, {s}!\n", .{"World"});
}

fn jacobianMatrix(allocator: Allocator, axes: u8) ![]f64 {
    const buffer = try allocator.alloc(f64, axes * axes);
    return buffer;
}
