const std = @import("std");


pub fn trapezoidal(f: fn (f128) f128, a: f128, b: f128) !f128 {
    const h = b - a;
    return h *
        (f(a) + f(b)) / 2;
}

pub fn simpson(f: fn (f128) f128, a: f128, b: f128) !f128 {
    const h = (b - a) / 2;
    return h / 3 *
        (f(a)
        + 4 * f(a + h)
        + f(b));
}

pub fn simpson38(f: fn (f128) f128, a: f128, b: f128) !f128 {
    const h = (b - a) / 3;
    return 3 * h / 8 *
        (f(a)
        + 3 * f(a + h)
        + 3 * f(a + 2 * h)
        + f(b));
}

pub fn boole(f: fn (f128) f128, a: f128, b: f128) !f128 {
    const h = (b - a) / 4;
    return 2 * h / 45 *
        (7 * f(a)
        + 32 * f(a + h)
        + 12 * f(a + 2 * h)
        + 32 * f(a + 3 * h)
        + 7 * f(b));
}

pub fn midpoint(f: fn (f128) f128, a: f128, b: f128) !f128 {
    return (b - a) * f((a + b) / 2);
}

pub fn milne(f: fn (f128) f128, a: f128, b: f128) !f128 {
    const h = (b - a) / 4;
    return 4 * h / 3 *
        (2 * f(a + h)
        - f(a + 2 * h)
        + 2 * f(a + 3 * h));
}
