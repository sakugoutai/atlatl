const std = @import("std");
const math = std.math;


fn isSameSign(a: f128, b: f128) bool {
	return a * b >= 0;
}

fn isInvalid(a: f128) bool {
	return math.isNan(a) or math.isInf(a);
}

pub fn bisection(f: fn (f128) f128, a: f128, b: f128, count: usize) error{SameSign}!f128 {
	if (isSameSign(f(a), f(b)))
		return error.SameSign;


	const middle = (a + b) / 2;

	return if (count == 0)
		return middle
	else if (isSameSign(f(a), f(middle)))
		bisection(f, middle, b, count - 1)
	else
		bisection(f, a, middle, count - 1);
}

pub fn newtonRaphson(f: fn (f128) f128, df: fn (f128) f128, a: f128, count: usize) !f128 {
	return if (count == 0)
		a
	else
		newtonRaphson(f, df, a - f(a) / df(a), count - 1);
}

pub fn secant(f: fn (f128) f128, a: f128, b: f128, count: usize) !f128 {
   return if (count == 0)
		b
	else
		secant(f, b, b - f(b) * (b - a) / (f(b) - f(a)), count - 1);
}

pub fn regulaFalsi(f: fn (f128) f128, a: f128, b: f128, count: usize) error{SameSign}!f128 {
	if (isSameSign(f(a), f(b)))
		return error.SameSign;


	const c = (a * f(b) - b * f(a)) / (f(b) - f(a));

    return if (count == 0)
		c
    else if (isSameSign(f(a), f(c)))
        regulaFalsi(f, c, b, count - 1)
    else
        regulaFalsi(f, a, c, count - 1);
}

pub fn safeBisection(f: fn (f128) f128, a: f128, b: f128, count: usize) error{Invalid, FaInvalid, FbInvalid, SameSign}!f128 {
	if (isInvalid(a) or isInvalid(b))
	    return error.Invalid;

	if (isInvalid(f(a)))
		return error.FaInvalid;

	if (isInvalid(f(b)))
		return error.FbInvalid;

	if (isSameSign(f(a), f(b)))
		return error.SameSign;


	const middle = (a + b) / 2;

	return if (count == 0)
		return middle
	else if (isSameSign(f(a), f(middle)))
		safeBisection(f, middle, b, count - 1) catch |err| switch (err) {
			error.FaInvalid => b,
			error.FbInvalid => middle,
			else => unreachable
		}
	else
		safeBisection(f, a, middle, count - 1) catch |err| switch (err) {
			error.FaInvalid => middle,
			error.FbInvalid => a,
			else => unreachable
		};
}

pub fn safeNewtonRaphson(f: fn (f128) f128, df: fn (f128) f128, a: f128, count: usize) error{Invalid, FaInvalid}!f128 {
	if (isInvalid(a))
	    return error.Invalid;

	if (isInvalid(f(a)))
		return error.FaInvalid;



	return if (count == 0)
		a
	else
		safeNewtonRaphson(f, df, a - f(a) / df(a), count - 1) catch a;
}

pub fn safeSecant(f: fn (f128) f128, a: f128, b: f128, count: usize) error{Invalid, FaInvalid, FbInvalid}!f128 {
	if (isInvalid(a) or isInvalid(b))
	    return error.Invalid;

	if (isInvalid(f(a)))
		return error.FaInvalid;

	if (isInvalid(f(b)))
		return error.FbInvalid;


   return if (count == 0)
		b
	else
		safeSecant(f, b, b - f(b) * (b - a) / (f(b) - f(a)), count - 1) catch |err| switch (err) {
			error.Invalid => b,
			error.FbInvalid => b,
			else => unreachable
		};
}

pub fn safeRegulaFalsi(f: fn (f128) f128, a: f128, b: f128, count: usize) error{Invalid, FaInvalid, FbInvalid, SameSign}!f128 {
	if (isInvalid(a) or isInvalid(b))
	    return error.Invalid;

	if (isInvalid(f(a)))
		return error.FaInvalid;

	if (isInvalid(f(b)))
		return error.FbInvalid;

	if (isSameSign(f(a), f(b)))
		return error.SameSign;


	const c = (a * f(b) - b * f(a)) / (f(b) - f(a));

    return if (count == 0)
		c
    else if (isSameSign(f(a), f(c)))
        safeRegulaFalsi(f, c, b, count - 1) catch |err| switch (err) {
			error.Invalid => b,
			error.FaInvalid => b,
			else => unreachable
		}
    else
        safeRegulaFalsi(f, a, c, count - 1) catch |err| switch (err) {
			error.Invalid => a,
			error.FbInvalid => a,
			else => unreachable
		};
}
