const std = @import("std");
const heap = std.heap;

const Atlatl = @import("Atlatl.zig");
const String = Atlatl.Base.String;
const Integer = Atlatl.Num.Integer;
const Rational = Atlatl.Num.Rational;
const Number = Atlatl.Num.Number;
const Operation = Atlatl.Num.Operation;


pub fn main() !void {
    var arena = heap.ArenaAllocator.init(heap.page_allocator);
    defer arena.deinit();

    const a = Number {
        .Integer = try Integer.init(arena.allocator(),
            "12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
        )
    };

    const stdout = std.io.getStdOut().writer();
    try stdout.print("{s}\n", .{ a.Integer.integer.getPrimitive() });

    const tmp = Operation.add(a, a);
    try stdout.print("{s}\n", .{ tmp.Integer.integer.getPrimitive() });
}
