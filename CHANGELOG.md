# Changelog

All notable changes to Synapse will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Initial Synapse implementation
- Zig-based Rust struct parser
- SwiftUI ViewModel generator
- iOS 17+ @Observable support
- Legacy @ObservableObject support (iOS 14-16)
- Justfile integration
- RSR Gold compliance documentation

### Changed
- Nothing yet

### Deprecated
- Nothing yet

### Removed
- Nothing yet

### Fixed
- Nothing yet

### Security
- Nothing yet

## [0.1.0] - 2024-01-XX

### Added
- Core parser for Rust struct definitions (`src/parser/rust_parser.zig`)
- Swift template system (`src/templates/swift_templates.zig`)
- Main generator CLI (`src/generators/synapse.zig`)
- Support for derive attributes: `Synapse`, `DriftUI`, `SwiftBridge`
- Type mapping: Rust primitives to Swift types
- Generated ViewModel pattern with `@Observable` (iOS 17+)
- Generated ViewModel pattern with `@ObservableObject` (legacy)
- Convenience `from(rust:)` initializers
- SwiftUI Preview generation
- Justfile commands: `build`, `gen-ui`, `gen-ui-legacy`, `test`, `clean`
- Example Rust models demonstrating usage
- Comprehensive RSR Gold documentation

### Technical Details
- Written in Zig for fast compilation and transparent memory management
- No external dependencies beyond Zig standard library
- Parses Rust source directly (no intermediate format)
- Template-based generation for easy Apple spec updates

---

## Release Notes Format

Each release includes:
- **Added**: New features
- **Changed**: Changes to existing functionality
- **Deprecated**: Features to be removed in future versions
- **Removed**: Features removed in this version
- **Fixed**: Bug fixes
- **Security**: Security-related changes

## Versioning Policy

- **Major** (X.0.0): Breaking changes to CLI interface or generated output format
- **Minor** (0.X.0): New features, new supported types, template improvements
- **Patch** (0.0.X): Bug fixes, documentation updates, internal improvements

## Upgrade Guide

When upgrading between versions:

1. Read the changelog for breaking changes
2. Regenerate all Swift files: `just gen-ui`
3. Test your application
4. Update any custom templates if needed
