const std = @import("std");

const Atlatl = @import("Atlatl.zig");
const Numerical = Atlatl.Numerical;

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    // bisection method
    const root = try Numerical.RootFinding.bisection(f, 0, 4, 1000);
    try stdout.print("{d}\n", .{ root });

    // Newton-Raphson's method
    const root2 = try Numerical.RootFinding.newtonRaphson(f, df, 4, 1000);
    try stdout.print("{d}\n", .{ root2 });

    // secant method
    const root3 = try Numerical.RootFinding.secant(f, 0, 4, 10);
    try stdout.print("{d}\n", .{ root3 });

    // regula falsi
    const root4 = try Numerical.RootFinding.regulaFalsi(f, 0, 4, 1000);
    try stdout.print("{d}\n", .{ root4 });

    // Brent's method

    // Steffensen's method
}

fn f(x: f128) f128 {
    return x * x - 2;
}

fn df(x: f128) f128 {
    return 2 * x;
}
