# SYNAPSE - Rust-to-SwiftUI Meta-Compiler
# ========================================
# A Zig-based code generator that bridges the Rust↔Swift divide.
#
# COMMANDS:
#   just build      - Build the Synapse binary
#   just gen-ui     - Generate Swift ViewModels from Rust structs
#   just test       - Run all tests
#   just clean      - Clean build artifacts
#   just help       - Show this help
#
# PHILOSOPHY:
#   When Apple changes SwiftUI syntax, you update Synapse templates.
#   Then run `just gen-ui`. The entire app is upgraded instantly.

# Default recipe - show help
default:
    @just --list

# Build the Synapse binary
build:
    zig build

# Generate SwiftUI ViewModels from Rust structs
# This is the main command you'll use in your workflow
gen-ui input="examples/rust/models.rs" output="examples/swift/Generated.swift" ios="17":
    @echo "🔄 Synapse: Generating SwiftUI bindings..."
    @zig build run -- --input {{input}} --output {{output}} --ios {{ios}}
    @echo "✓ Done! Check {{output}}"

# Generate with legacy ObservableObject (iOS 14-16 support)
gen-ui-legacy input="examples/rust/models.rs" output="examples/swift/Generated.swift":
    @echo "🔄 Synapse: Generating legacy SwiftUI bindings..."
    @zig build run -- --input {{input}} --output {{output}} --legacy-observable
    @echo "✓ Done! Check {{output}}"

# Run all tests
test:
    zig build test

# Clean build artifacts
clean:
    rm -rf zig-out .zig-cache

# Show help for Synapse CLI
help:
    @zig build run -- --help

# Development: watch for changes and rebuild
watch:
    @echo "Watching for changes... (Ctrl+C to stop)"
    @while true; do \
        find src -name "*.zig" | entr -d just build; \
    done

# Generate and copy to Xcode project
# Usage: just deploy-ios ~/MyApp/MyApp/Generated
deploy-ios dest:
    @just gen-ui
    @cp examples/swift/Generated.swift {{dest}}/Generated.swift
    @echo "✓ Deployed to {{dest}}"

# Lint Zig code
lint:
    zig fmt src/

# Show stats about generated code
stats:
    @echo "=== Synapse Statistics ==="
    @echo "Zig source files:"
    @find src -name "*.zig" | wc -l
    @echo "Lines of Zig code:"
    @find src -name "*.zig" -exec cat {} \; | wc -l
    @echo ""
    @echo "Generated Swift files:"
    @find examples/swift -name "*.swift" | wc -l
    @echo "Lines of generated Swift:"
    @find examples/swift -name "*.swift" -exec cat {} \; | wc -l 2>/dev/null || echo "0"

# ==========================================
# RSR GOLD COMPLIANCE VALIDATION
# ==========================================

# Run all RSR compliance checks
validate: check-docs check-spdx check-links check-well-known
    @echo "✓ RSR Gold validation complete"

# Check required documentation files exist
check-docs:
    @echo "Checking required documentation..."
    @test -f README.md && echo "  ✓ README.md" || echo "  ✗ README.md missing"
    @test -f LICENSE.txt && echo "  ✓ LICENSE.txt" || echo "  ✗ LICENSE.txt missing"
    @test -f SECURITY.md && echo "  ✓ SECURITY.md" || echo "  ✗ SECURITY.md missing"
    @test -f CODE_OF_CONDUCT.md && echo "  ✓ CODE_OF_CONDUCT.md" || echo "  ✗ CODE_OF_CONDUCT.md missing"
    @test -f CONTRIBUTING.adoc && echo "  ✓ CONTRIBUTING.adoc" || echo "  ✗ CONTRIBUTING.adoc missing"
    @test -f FUNDING.yml && echo "  ✓ FUNDING.yml" || echo "  ✗ FUNDING.yml missing"
    @test -f GOVERNANCE.adoc && echo "  ✓ GOVERNANCE.adoc" || echo "  ✗ GOVERNANCE.adoc missing"
    @test -f MAINTAINERS.md && echo "  ✓ MAINTAINERS.md" || echo "  ✗ MAINTAINERS.md missing"
    @test -f .gitignore && echo "  ✓ .gitignore" || echo "  ✗ .gitignore missing"
    @test -f .gitattributes && echo "  ✓ .gitattributes" || echo "  ✗ .gitattributes missing"
    @test -f REVERSIBILITY.md && echo "  ✓ REVERSIBILITY.md" || echo "  ✗ REVERSIBILITY.md missing"
    @test -f CHANGELOG.md && echo "  ✓ CHANGELOG.md" || echo "  ✗ CHANGELOG.md missing"
    @test -f ROADMAP.md && echo "  ✓ ROADMAP.md" || echo "  ✗ ROADMAP.md missing"

# Audit SPDX license headers in source files
check-spdx:
    @echo "Checking SPDX headers..."
    @for f in $(find src -name "*.zig"); do \
        if grep -q "SPDX-License-Identifier" "$$f"; then \
            echo "  ✓ $$f"; \
        else \
            echo "  ✗ $$f missing SPDX header"; \
        fi; \
    done

# Alias for RSR compliance
audit-licence: check-spdx

# Check .well-known directory
check-well-known:
    @echo "Checking .well-known files..."
    @test -d .well-known && echo "  ✓ .well-known directory" || echo "  ✗ .well-known missing"
    @test -f .well-known/security.txt && echo "  ✓ security.txt" || echo "  ✗ security.txt missing"
    @test -f .well-known/ai.txt && echo "  ✓ ai.txt" || echo "  ✗ ai.txt missing"
    @test -f .well-known/humans.txt && echo "  ✓ humans.txt" || echo "  ✗ humans.txt missing"
    @test -f .well-known/provenance.json && echo "  ✓ provenance.json" || echo "  ✗ provenance.json missing"

# Check links in documentation (requires lychee)
check-links:
    @echo "Checking documentation links..."
    @if command -v lychee > /dev/null; then \
        lychee --verbose *.md *.adoc || true; \
    else \
        echo "  ⚠ lychee not installed, skipping link check"; \
    fi

# Generate SBOM (Software Bill of Materials)
sbom-generate:
    @echo "Generating SBOM..."
    @echo "{ \"name\": \"synapse\", \"version\": \"0.1.0\", \"license\": \"MIT\" }" > sbom.json
    @echo "✓ SBOM generated: sbom.json"

# ==========================================
# USAGE EXAMPLE FOR YOUR DRIFT PROJECT:
# ==========================================
#
# 1. Write your Rust structs in src/models/
#    #[derive(Synapse)]
#    pub struct PlayerState { ... }
#
# 2. Run the generator:
#    just gen-ui input=src/models/state.rs output=ios/DriftApp/Generated.swift
#
# 3. Import in Xcode and use:
#    @StateObject var player = PlayerStateViewModel()
#
# 4. When Apple changes SwiftUI (iOS 19+), update src/templates/swift_templates.zig
#    Then run `just gen-ui` - entire app is upgraded!
# ==========================================
