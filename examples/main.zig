const std = @import("std");
const fs = std.fs;

const atlatl = @import("atlatl");
const numerical = atlatl.numerical;


pub fn main() !void {
    var stdout = fs.File.stdout().writerStreaming(&.{});

    // Root Finding
    // bisection method
    var root = try numerical.root_finding.bisection(f, 0, 4, 1000);
    try stdout.interface.print("{d}\n", .{ root });

    // Newton-Raphson's method
    root = try numerical.root_finding.newtonRaphson(f, df, 4, 1000);
    try stdout.interface.print("{d}\n", .{ root });

    // secant method
    root = try numerical.root_finding.secant(f, 0, 4, 10);
    try stdout.interface.print("{d}\n", .{ root });

    // regula falsi
    root = try numerical.root_finding.regulaFalsi(f, 0, 4, 1000);
    try stdout.interface.print("{d}\n", .{ root });

    // Brent's method

    // Steffensen's method


    // Integration
    // trapezoidal rule
    var integral = try numerical.integration.trapezoidal(f, -40, 40);
    try stdout.interface.print("{d}\n", .{ integral });

    // Simpson's rule
    integral = try numerical.integration.simpson(f, -40, 40);
    try stdout.interface.print("{d}\n", .{ integral });

    // Simpson's 3/8 rule
    integral = try numerical.integration.simpson38(f, -40, 40);
    try stdout.interface.print("{d}\n", .{ integral });

    // Boole's rule
    integral = try numerical.integration.boole(f, -40, 40);
    try stdout.interface.print("{d}\n", .{ integral });

    // Midpoint rule
    integral = try numerical.integration.midpoint(f, -40, 40);
    try stdout.interface.print("{d}\n", .{ integral });

    // Milne's rule
    integral = try numerical.integration.milne(f, -40, 40);
    try stdout.interface.print("{d}\n", .{ integral });
}

fn f(x: f128) f128 {
    return x * x - 2;
}

fn df(x: f128) f128 {
    return 2 * x;
}
