const std = @import("std");
const math = std.math;


pub fn bisection(f: fn (f128) f128, a: f128, b: f128, count: usize) !f128 {
    if (f(a) * f(b) > 0)
        return error.NoSignChange;

    var left : f128 = a;
    var right: f128 = b;
    var root : f128 = 0;

    for (0..count) |_| {
        root = (left + right) / 2;

        if (f(left) * f(root) > 0) {
            left = root;
        } else {
            right = root;
        }
    }

    return root;
}

pub fn newton_raphson(f: fn (f128) f128, df: fn (f128) f128, a: f128, count: usize) f128 {
    var root: f128 = a;

    for (0..count) |_| {
        root = root - f(root)/df(root);
    }

    return root;
}

pub fn secant(f: fn (f128) f128, a: f128, b: f128, count: usize) !f128 {
    if (f(a) * f(b) > 0)
        return error.NoSignChange;

    var root_prev: f128 = a;
    var root     : f128 = b;
    var temp     : f128 = 0;

    for (0..count) |_| {
        temp = root;
        root = root - f(root) * (root - root_prev)/(f(root) - f(root_prev));
        root_prev = temp;
    }

    return root;
}
