const std = @import("std");
const Allocator = std.mem.Allocator;

const Base = @import("../Base.zig");
const String = Base.String;


pub const Number = struct {

	allocator: Allocator,

	system: System,

	integer: String,

	numerator: String,
	denominator: String,

	constant: Constant,

	index: String,
	radicant: String,

	pub const System = enum {
		Z,
		Q,
		RConstant,
		RRoot,
	};

	pub const Constant = enum {
		pi,
		e,
		phi,
		gamma,
	};

	pub fn Z(allocator: Allocator, integer: []const u8) Allocator.Error!Number {
		return Number {
			.allocator		= allocator,

			.system			= Number.System.Z,

			.integer		= try String.init(allocator, integer),

			.numerator		= try String.init(allocator, ""),
			.denominator	= try String.init(allocator, ""),

			.constant		= Number.Constant.pi,

			.index			= try String.init(allocator, ""),
			.radicant		= try String.init(allocator, ""),
		};
	}

	pub fn Q(allocator: Allocator, numerator: String, denominator: String) Allocator.Error!Number {
		return Number {
			.allocator		= allocator,

			.system			= Number.System.Q,

			.integer		= try String.init(allocator, ""),

			.numerator		= try String.initCopy(numerator),
			.denominator	= try String.initCopy(denominator),

			.constant		= Number.Constant.pi,

			.index			= try String.init(allocator, ""),
			.radicant		= try String.init(allocator, ""),
		};
	}

	pub fn RConstant(allocator: Allocator, constant: Number.Constant) Allocator.Error!Number {
		return Number {
			.allocator		= allocator,

			.system			= Number.System.R,

			.integer		= try String.init(allocator, ""),

			.numerator		= try String.init(allocator, ""),
			.denominator	= try String.init(allocator, ""),

			.constant		= constant,

			.index			= try String.init(allocator, ""),
			.radicant		= try String.init(allocator, ""),
		};
	}

	pub fn RRoot(allocator: Allocator, index: String, radicant: String) Allocator.Error!Number {
		return Number {
			.allocator		= allocator,

			.system			= Number.System.R,

			.integer		= try String.init(allocator, ""),

			.numerator		= try String.init(allocator, ""),
			.denominator	= try String.init(allocator, ""),

			.constant		= Number.Constant.pi,

			.index			= try String.initCopy(index),
			.radicant		= try String.initCopy(radicant),
		};
	}

    pub fn deinit(self: Number) void {
        self.allocator.free(self.integer);
        self.allocator.free(self.numerator);
        self.allocator.free(self.denominator);
        self.allocator.free(self.index);
        self.allocator.free(self.radicant);
    }

};
