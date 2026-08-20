const std = @import("std");
const expect = std.testing.expect;

// This is where the jacobian and CCD math goes

const MatrixError = error{
    InvalidSizeError,
};

fn Matrix(
    comptime T: type,
    comptime rows: usize,
    comptime cols: usize,
) type {
    return struct {
        const Self = @This();

        // Coulmn Major
        data: [cols][rows]T,
        rows: usize,
        cols: usize,

        // ----- Constructors -----
        pub fn init(value: T) Self {
            var mat: Self = undefined;

            inline for (0..rows) |x| {
                inline for (0..cols) |y| {
                    mat.data[y][x] = value;
                }
            }

            return mat;
        }

        pub fn init_zero() Self {
            // TODO: Convert this to SIMD using Vector

            var mat: Self = undefined;

            inline for (0..rows) |x| {
                inline for (0..cols) |y| {
                    mat.data[y][x] = 0;
                }
            }

            return mat;
        }

        pub fn init_ident() !Self {
            if (rows != cols) return MatrixError.InvalidSizeError;

            var mat: Self = undefined;
            inline for (0..rows) |x| {
                inline for (0..cols) |y| {
                    if (x == y) {
                        mat.data[y][x] = 1;
                    } else {
                        mat.data[y][x] = 0;
                    }
                }
            }

            return mat;
        }

        // ----- Math Operations -----

        pub fn dot_prod(mat: Self, other: Self) !T {
            if (mat.rows != other.cols) return MatrixError.InvalidSizeError;

            var result: T = 0;

            for (0..rows) |x| {
                for (0..cols) |y| {
                    result += mat.data[x][y] * other.data[y][x];
                }
            }

            return result;
        }

        // ----- Order Operations -----

        // ----- Formatting / Misc -----
        pub fn print(mat: Self) void {
            for (0..rows) |x| {
                for (0..cols) |y| {
                    std.debug.print("{d} ", .{mat.data[y][x]});
                }
                std.debug.print("\n", .{});
            }
        }
    };
}

test "matrix init" {}

pub fn main() !void {
    var mat_3_3 = Matrix(f32, 3, 3).init_zero();
    var mat_2_3 = Matrix(f32, 2, 3).init(3.21);
    var mat_2_2 = try Matrix(f32, 2, 2).init_ident();
    var mat_4_2 = Matrix(f32, 4, 2).init(1.25);
    var mat_2_4 = Matrix(f32, 2, 4).init(0.75);

    mat_3_3.print();
    mat_2_3.print();
    mat_2_2.print();
    mat_4_2.print();
    mat_2_4.print();

    const res = try mat_4_2.dot_prod(mat_2_4);
    std.debug.print("DOT: {d}\n", .{res});

    var mat_3_2 = Matrix(f32, 3, 2).init_ident() catch |err| {
        if (err == MatrixError.InvalidSizeError) {
            std.debug.print("Invalid matrix size for identity matrix\n", .{});
        }

        return;
    };
    mat_3_2.print();
}
