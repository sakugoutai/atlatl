const std = @import("std");
const heap = std.heap;

const Atlatl = @import("Atlatl.zig");
const String = Atlatl.Base.String;
const Number = Atlatl.Number.Number;


pub fn main() !void {
    var arena = heap.ArenaAllocator.init(heap.page_allocator);
    defer arena.deinit();

    const a = try Number.Z(arena.allocator(),
        "12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
    );

    const stdout = std.io.getStdOut().writer();
    try stdout.print("{s}\n", .{ a.integer.getPrimitive() });
}
