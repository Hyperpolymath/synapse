# Roadmap

This document outlines the planned development direction for Synapse.

## Vision

Synapse aims to be the definitive tool for bridging Rust and SwiftUI, eliminating boilerplate while maintaining type safety and Apple platform compliance.

## Current Status: v0.1.0 (Alpha)

Core functionality implemented:
- [x] Rust struct parsing
- [x] Basic type mapping
- [x] ViewModel generation
- [x] iOS 17+ @Observable support
- [x] Legacy iOS support
- [x] Justfile integration

## Short Term

### v0.2.0 - Enhanced Type Support

- [ ] Generic type extraction (`Vec<T>` → `[T]`)
- [ ] Optional type handling (`Option<T>` → `T?`)
- [ ] Nested struct support
- [ ] Enum generation
- [ ] Associated type mapping

### v0.3.0 - UniFFI Integration

- [ ] Direct UniFFI UDL parsing
- [ ] Proc-macro attribute recognition
- [ ] Combined UniFFI + Synapse workflow
- [ ] Automatic `from(rust:)` using UniFFI bindings

## Medium Term

### v0.4.0 - Advanced SwiftUI Patterns

- [ ] `@Bindable` property generation
- [ ] Custom property wrappers
- [ ] Combine publisher generation
- [ ] async/await bridging

### v0.5.0 - Developer Experience

- [ ] Watch mode (`just watch`)
- [ ] Incremental generation
- [ ] Error messages with Rust source locations
- [ ] Xcode integration guide

### v0.6.0 - Testing & Validation

- [ ] Generated code validation
- [ ] Swift syntax checking
- [ ] Type compatibility verification
- [ ] Round-trip testing

## Long Term

### v1.0.0 - Stable Release

- [ ] API stability guarantee
- [ ] Comprehensive documentation
- [ ] Migration guides from manual approaches
- [ ] Performance benchmarks
- [ ] Community template registry

### Beyond v1.0.0

- [ ] Android/Kotlin support (via UniFFI)
- [ ] Web/TypeScript support
- [ ] Custom template language
- [ ] IDE plugins (VS Code, Xcode)
- [ ] WASM target for browser-based generation

## Non-Goals

Things Synapse will **not** do:

1. **Replace UniFFI**: Synapse complements UniFFI, doesn't replace it
2. **Generate Rust from Swift**: One-way generation only
3. **Runtime code**: Synapse is build-time only
4. **UI layout generation**: ViewModels only, not Views
5. **State management**: Generated ViewModels are simple containers

## End-of-Life Planning

### Deprecation Policy

1. Features deprecated with one minor version warning
2. Deprecated features removed in next major version
3. Migration guides provided for all breaking changes

### Succession

If Synapse development ceases:

1. Repository archived (not deleted)
2. Documentation preserved
3. Fork rights maintained (MIT license)
4. Last stable version remains available

### Archive Strategy

Before archival:

1. Final release with all known fixes
2. Documentation of known limitations
3. List of recommended alternatives
4. Data export (not applicable - no stored data)

## Contributing to the Roadmap

We welcome input on the roadmap:

1. **Feature requests**: Open an issue with `enhancement` label
2. **Prioritization feedback**: Comment on roadmap issues
3. **Implementation**: See CONTRIBUTING.adoc

## Contact

- Roadmap questions: Open an issue with `roadmap` label
- General questions: See MAINTAINERS.md
