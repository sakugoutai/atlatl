const std = @import("std");
const Allocator = std.mem.Allocator;

const Num = @import("../Num.zig");
const Integer = Num.Integer;


pub const Rational = struct {

	numerator: Integer,
	denominator: Integer,

	pub fn init(numerator: Integer, denominator: Integer) Allocator.Error!Rational {
		return Rational {
			.numerator		= numerator,
			.denominator	= denominator,
		};
	}

    pub fn deinit(self: Rational) void {
        self.numerator.deinit();
        self.denominator.deinit();
    }

};
