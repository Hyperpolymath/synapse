// SPDX-License-Identifier: MIT
// SPDX-FileCopyrightText: 2024 Synapse Contributors
//
// SYNAPSE Build Configuration
// Zig 0.11+ compatible

const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    // Main Synapse executable
    const exe = b.addExecutable(.{
        .name = "synapse",
        .root_source_file = b.path("src/generators/synapse.zig"),
        .target = target,
        .optimize = optimize,
    });

    // Add module dependencies
    const parser_mod = b.createModule(.{
        .root_source_file = b.path("src/parser/rust_parser.zig"),
    });
    const templates_mod = b.createModule(.{
        .root_source_file = b.path("src/templates/swift_templates.zig"),
    });

    exe.root_module.addImport("parser", parser_mod);
    exe.root_module.addImport("templates", templates_mod);

    // Allow templates to import parser
    templates_mod.addImport("parser", parser_mod);

    b.installArtifact(exe);

    // Run command: `zig build run`
    const run_cmd = b.addRunArtifact(exe);
    run_cmd.step.dependOn(b.getInstallStep());

    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    const run_step = b.step("run", "Run Synapse generator");
    run_step.dependOn(&run_cmd.step);

    // Test command: `zig build test`
    const unit_tests = b.addTest(.{
        .root_source_file = b.path("src/generators/synapse.zig"),
        .target = target,
        .optimize = optimize,
    });

    const parser_tests = b.addTest(.{
        .root_source_file = b.path("src/parser/rust_parser.zig"),
        .target = target,
        .optimize = optimize,
    });

    const template_tests = b.addTest(.{
        .root_source_file = b.path("src/templates/swift_templates.zig"),
        .target = target,
        .optimize = optimize,
    });

    const run_unit_tests = b.addRunArtifact(unit_tests);
    const run_parser_tests = b.addRunArtifact(parser_tests);
    const run_template_tests = b.addRunArtifact(template_tests);

    const test_step = b.step("test", "Run unit tests");
    test_step.dependOn(&run_unit_tests.step);
    test_step.dependOn(&run_parser_tests.step);
    test_step.dependOn(&run_template_tests.step);
}
