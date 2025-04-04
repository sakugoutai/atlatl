const std = @import("std");
const Allocator = std.mem.Allocator;

const Base = @import("../Base.zig");
const String = Base.String;


pub const Integer = struct {

	allocator: Allocator,
	integer: String,

	pub fn init(allocator: Allocator, integer: []const u8) Allocator.Error!Integer {
		return Integer {
			.allocator	= allocator,
			.integer	= try String.init(allocator, integer),
		};
	}

    pub fn deinit(self: Integer) void {
        self.allocator.free(self.integer);
    }

};
