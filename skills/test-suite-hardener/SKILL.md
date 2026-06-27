---
name: test-suite-hardener
description: Improve test suites by adding meaningful coverage, reducing flakiness, and making failures easier to diagnose. Use when Codex needs to add regression tests, stabilize flaky tests, improve fixtures, choose test levels, or increase confidence around risky code changes.
---

# Test Suite Hardener

Make tests more trustworthy, not merely more numerous. Favor tests that catch real regressions and fail with useful signals.

## Workflow

1. Identify the risk:
   - What behavior changed?
   - Who consumes it?
   - What edge cases would be expensive if missed?
   - Which test level catches the behavior with the least setup?
2. Read local patterns:
   - Existing test framework, fixture style, factories, mocks, naming, and assertions.
   - Project commands from manifests and CI config.
   - Nearby tests before creating new structures.
3. Add or improve tests:
   - Put tests beside comparable coverage.
   - Use deterministic data and stable clocks.
   - Assert behavior through public contracts.
   - Keep one test focused on one reason to fail.
4. Run narrowly first:
   - Run the specific test file or test name.
   - Then run adjacent suite or typecheck when shared code changed.
5. Tighten diagnostics:
   - Prefer explicit assertions over giant snapshots.
   - Give fixtures names that explain the scenario.
   - Add failure messages only when they clarify non-obvious intent.

## Choosing Test Level

- Pure transformation or validation: unit test.
- Module behavior with storage, cache, or framework glue: integration test.
- User flow across pages/services: e2e or feature test.
- Bug reproduction: start at the narrowest level that fails for the reported reason.
- Accessibility, responsive UI, or visual layout: browser test plus screenshot/manual verification when available.

## Flake Reduction

Look for:

- Wall-clock dependence.
- Random data without a seed.
- Sleep-based waiting.
- Shared mutable state across tests.
- Network calls and third-party services.
- Order dependence.
- Assertions before async work settles.

Prefer:

- Fake timers or injected clocks.
- Deterministic factories.
- Event-driven waits.
- Isolated temp dirs/databases.
- Boundary mocks at external services only.
- Test cleanup through existing framework hooks.

## Coverage That Matters

Add tests around:

- Permission boundaries and tenant scoping.
- Empty, missing, malformed, and maximum inputs.
- Error handling and partial failure.
- Serialization/deserialization changes.
- Migration compatibility.
- Public API responses and schema changes.
- UI loading, error, empty, disabled, and success states.

## Guardrails

- Do not chase arbitrary coverage percentages at the expense of clarity.
- Do not update snapshots without inspecting the semantic change.
- Do not mock the function under test.
- Do not remove assertions to make a test pass unless the product contract changed and the new contract is documented.
- If a broad suite fails unrelatedly, report the failure and keep the task focused.
