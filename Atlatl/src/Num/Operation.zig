const Num = @import("../Num.zig");
const Number = Num.Number;

pub fn add(a: Number, b: Number) Number {
    _ = b;
    return a;
}