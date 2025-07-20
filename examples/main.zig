const std = @import("std");

const atlatl = @import("atlatl");
const numerical = atlatl.numerical;


pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    // Root Finding
    // bisection method
    var root = try numerical.RootFinding.bisection(f, 0, 4, 1000);
    try stdout.print("{d}\n", .{ root });

    // Newton-Raphson's method
    root = try numerical.RootFinding.newtonRaphson(f, df, 4, 1000);
    try stdout.print("{d}\n", .{ root });

    // secant method
    root = try numerical.RootFinding.secant(f, 0, 4, 10);
    try stdout.print("{d}\n", .{ root });

    // regula falsi
    root = try numerical.RootFinding.regulaFalsi(f, 0, 4, 1000);
    try stdout.print("{d}\n", .{ root });

    // Brent's method

    // Steffensen's method


    // Integration
    // trapezoidal rule
    var integral = try numerical.Integration.trapezoidal(f, -40, 40);
    try stdout.print("{d}\n", .{ integral });

    // Simpson's rule
    integral = try numerical.Integration.simpson(f, -40, 40);
    try stdout.print("{d}\n", .{ integral });

    // Simpson's 3/8 rule
    integral = try numerical.Integration.simpson38(f, -40, 40);
    try stdout.print("{d}\n", .{ integral });

    // Boole's rule
    integral = try numerical.Integration.boole(f, -40, 40);
    try stdout.print("{d}\n", .{ integral });

    // Midpoint rule
    integral = try numerical.Integration.midpoint(f, -40, 40);
    try stdout.print("{d}\n", .{ integral });

    // Milne's rule
    integral = try numerical.Integration.milne(f, -40, 40);
    try stdout.print("{d}\n", .{ integral });
}

fn f(x: f128) f128 {
    return x * x - 2;
}

fn df(x: f128) f128 {
    return 2 * x;
}
