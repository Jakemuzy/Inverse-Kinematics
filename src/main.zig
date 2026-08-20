const std = @import("std");
const robot = @import("robot.zig");
const Arm = robot.Arm;
const Allocator = std.heap.DebugAllocator;

// oO0(entry)0Oo

const expect = std.testing.expect;

const steps: u16 = 7200;
const angle_differential: f32 = 360 / steps;

pub fn main() !void {
    var gpa: Allocator(.{}) = .init;
    const allocator = gpa.allocator();
    defer {
        _ = gpa.deinit();
    }

    const jacobian = jacobianMatrix(allocator, 3) catch |err| {
        std.debug.print("Error: {}\n", .{err});
        return;
    };
    defer allocator.free(jacobian);

    for (0..jacobian.len) |idx| {
        jacobian[idx] = @floatFromInt(idx);
    }

    // std.debug.print("Hello, {s}!\n", .{"World"});
    var arm2: Arm = try Arm.init(allocator, &[_]usize{ 1, 2, 3, 1 });
    defer arm2.deinit(allocator);
    arm2.print();
}

fn jacobianMatrix(allocator: std.mem.Allocator, axes: u8) ![]f64 {
    return try allocator.alloc(f64, axes * axes);
    // TODO: Fill
}
