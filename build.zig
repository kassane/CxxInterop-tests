const std = @import("std");

pub fn build(b: *std.Build) void {
    const optimize = b.standardOptimizeOption(.{});
    var target = b.standardTargetOptions(.{});

    // for Windows overwritten default abi (mingw to msvc)
    if (target.isWindows()) {
        target.abi = .msvc;
    }

    buildExe(b, .{
        .path = "extern_c/zig/extern_c.main.zig",
        .target = target,
        .optimize = optimize,
    });
    buildExe(b, .{
        .path = "bindgen/zig/bindgen.main.zig",
        .target = target,
        .optimize = optimize,
    });
    // TODO: WIP
    // buildExe(b, .{
    //     .path = "cxx/zig/cxx.main.zig",
    //     .target = target,
    //     .optimize = optimize,
    // });
}

fn buildExe(b: *std.Build, properties: BuildInfo) void {
    const exe = b.addExecutable(.{
        .name = properties.filename(),
        .root_source_file = FileSource.relative(properties.path),
        .target = properties.target,
        .optimize = properties.optimize,
    });
    if (std.mem.eql(u8, properties.filename(), "extern_c")) {
        exe.addCSourceFile("extern_c/cpp/cats.cpp", &.{});
    } else if (std.mem.eql(u8, properties.filename(), "bindgen")) {
        exe.addCSourceFile("bindgen/cpp/cats.cpp", &.{});
    } else {}
    //     exe.addIncludePath("cxx/cpp");
    //     exe.addIncludePath("target/cxxbridge/cats_cxx/src");
    //     exe.addIncludePath("target/cxxbridge/rust");
    //     exe.addCSourceFiles(&.{
    //         "cxx/cpp/cats.cpp",
    //         "target/cxxbridge/cats_cxx/src/main.rs.cc",
    //     }, &.{
    //         "-Wall",
    //         "-Wextra",
    //         "-std=c++20",
    //     });
    //     // exe.step.dependOn(&cxxBridge(b).step);
    // }

    // nostdlib++: zig to msvc target don't has libc++ support yet.
    if (properties.target.getAbi() == .msvc) {
        // need winsdk and crt installed, run cmd: zig libc (to detect os-libc)
        exe.linkLibC();
    } else exe.linkLibCpp(); //static llvm-libcxx

    b.installArtifact(exe);

    const run_cmd = b.addRunArtifact(exe);
    const run_step = b.step(properties.filename(), b.fmt("Run the {s} app", .{properties.filename()}));
    run_step.dependOn(&run_cmd.step);
}

const BuildInfo = struct {
    path: []const u8,
    target: Target,
    optimize: OptimizeMode,
    fn filename(self: BuildInfo) []const u8 {
        var split = std.mem.split(u8, std.fs.path.basename(self.path), ".");
        return split.first();
    }
};

fn cxxBridge(b: *std.Build) *std.Build.Step.Run {
    const cxx = b.addSystemCommand(&[_][]const u8{ "cargo", "build", "--release" });
    return cxx;
}
const Target = std.zig.CrossTarget;
const OptimizeMode = std.builtin.OptimizeMode;
const FileSource = std.Build.FileSource;
