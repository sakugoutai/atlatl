const std = @import("std");

const Num = @import("../Num.zig");
const Integer = Num.Integer;
const Rational = Num.Rational;


pub const Number = union(enum) {
    Integer: Integer,
    Rational: Rational,
};
