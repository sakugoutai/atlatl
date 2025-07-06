const std = @import("std");

const Atlatl = @import("Atlatl.zig");
const NumericalAnalysis = Atlatl.NumericalAnalysis;

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    // bisection method
    const root = try NumericalAnalysis.RootFinding.bisection(f, 0, 4, 10);
    try stdout.print("{d}\n", .{ root });

    // Newton-Raphson's method
    const root2 = NumericalAnalysis.RootFinding.newton_raphson(f, df, 4, 10);
    try stdout.print("{d}\n", .{ root2 });

    // secant method
    const root3 = try NumericalAnalysis.RootFinding.secant(f, 0, 4, 10);
    try stdout.print("{d}\n", .{ root3 });

    // regula falsi

    // Brent's method

    // Steffensen's method
}

fn f(x: f128) f128 {
    return x * x - 2;
}

fn df(x: f128) f128 {
    return 2 * x;
}
