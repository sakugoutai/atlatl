const std = @import("std");

const Atlatl = @import("Atlatl.zig");
const Numerical = Atlatl.Numerical;

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    // Root Finding
    // bisection method
    var root = try Numerical.RootFinding.bisection(f, 0, 4, 1000);
    try stdout.print("{d}\n", .{ root });

    // Newton-Raphson's method
    root = try Numerical.RootFinding.newtonRaphson(f, df, 4, 1000);
    try stdout.print("{d}\n", .{ root });

    // secant method
    root = try Numerical.RootFinding.secant(f, 0, 4, 10);
    try stdout.print("{d}\n", .{ root });

    // regula falsi
    root = try Numerical.RootFinding.regulaFalsi(f, 0, 4, 1000);
    try stdout.print("{d}\n", .{ root });

    // Brent's method

    // Steffensen's method


    // Integration
    // trapezoidal rule
    var integral = try Numerical.Integration.trapezoidal(f, -40, 40);
    try stdout.print("{d}\n", .{ integral });

    // Simpson's rule
    integral = try Numerical.Integration.simpson(f, -40, 40);
    try stdout.print("{d}\n", .{ integral });

    // Simpson's 3/8 rule
    integral = try Numerical.Integration.simpson38(f, -40, 40);
    try stdout.print("{d}\n", .{ integral });

    // Boole's rule
    integral = try Numerical.Integration.boole(f, -40, 40);
    try stdout.print("{d}\n", .{ integral });

    // Midpoint rule
    integral = try Numerical.Integration.midpoint(f, -40, 40);
    try stdout.print("{d}\n", .{ integral });

    // Milne's rule
    integral = try Numerical.Integration.milne(f, -40, 40);
    try stdout.print("{d}\n", .{ integral });
}

fn f(x: f128) f128 {
    return x * x - 2;
}

fn df(x: f128) f128 {
    return 2 * x;
}
