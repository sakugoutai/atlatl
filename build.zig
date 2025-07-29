const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const atlatl_mod = b.addModule("atlatl", .{
        .root_source_file = b.path("src/atlatl.zig"),
        .target           = target,
        .optimize         = optimize,
    });

    const main_exe = b.addExecutable(.{
        .name = "main",
        .root_module = b.createModule(.{
            .root_source_file = b.path("examples/main.zig"),
            .target = target,
            .optimize = optimize,
            .imports = &.{
                .{ .name = "atlatl", .module = atlatl_mod },
            },
        }),
    });
    b.installArtifact(main_exe);

    const run_step = b.step("run", "Run the app");
    const run_cmd = b.addRunArtifact(main_exe);
    if (b.args) |args| {
        run_cmd.addArgs(args);
    }
    run_step.dependOn(&run_cmd.step);
}
