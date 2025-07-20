const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const ariadne_pkg = b.dependency("ariadne", .{
        .target   = target,
        .optimize = optimize,
    });

    const atlatl_mod = b.addModule("atlatl", .{
        .root_source_file = b.path("src/atlatl.zig"),
        .target           = target,
        .optimize         = optimize,
        .imports = &.{
            .{ .name = "ariadne", .module = ariadne_pkg.module("ariadne") },
        },
    });

    const exe_mod = b.createModule(.{
        .root_source_file = b.path("examples/main.zig"),
        .target = target,
        .optimize = optimize,
        .imports = &.{
            .{ .name = "ariadne", .module = ariadne_pkg.module("ariadne") },
            .{ .name = "atlatl", .module = atlatl_mod },
        },
    });

    const exe = b.addExecutable(.{
        .name = "main",
        .root_module = exe_mod,
    });
    b.installArtifact(exe);

    const run_cmd = b.addRunArtifact(exe);
    run_cmd.step.dependOn(b.getInstallStep());

    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);
}
