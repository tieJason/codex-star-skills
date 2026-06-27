---
name: bug-reproducer
description: Turn vague bug reports into concrete reproductions and regression tests. Use when Codex needs to investigate failing behavior, reproduce an issue locally, minimize a failing case, add a failing test before a fix, or verify that a bug fix truly closes the reported scenario.
---

# Bug Reproducer

Convert "it broke" into a named, repeatable failure. Prefer a small failing test or script over a long explanation.

## Workflow

1. Capture the claim:
   - Expected behavior.
   - Actual behavior.
   - Triggering inputs, environment, account state, flags, browser, locale, timezone, or data shape.
   - Error text, logs, screenshots, or stack traces.
2. Locate the likely path:
   - Search exact error messages, UI labels, endpoint paths, config keys, and domain nouns.
   - Inspect nearby tests before reading broad implementation.
   - Identify the smallest layer that can reproduce the failure without excessive setup.
3. Build the reproduction:
   - Prefer an existing test file and local test helper.
   - Use fixtures that describe the bug directly.
   - Keep the assertion on user-visible or contract-level behavior.
   - If a test is too expensive, create a tiny script or command sequence and document it.
4. Confirm the failure:
   - Run the narrow test or reproduction command.
   - Ensure it fails for the reported reason, not unrelated setup.
   - Preserve the failing signal in notes before implementing the fix.
5. Fix and re-run:
   - Apply the smallest behavioral fix.
   - Re-run the reproduction.
   - Run adjacent tests when the fix touches shared logic.

## Good Regression Tests

- Name the scenario in business or user terms.
- Assert the external contract, not incidental internals.
- Include the minimum setup needed to express the bug.
- Avoid sleeps, network calls, wall-clock dependence, and broad snapshots unless the project already uses them deliberately.
- Cover the edge value that failed and, when cheap, one normal value that should still work.

## When a Local Repro Is Hard

If the bug depends on production data, third-party services, or a rare race:

- Extract the relevant data shape into a fixture.
- Mock only the boundary that makes local execution impossible.
- Add logging or assertions that would catch the suspected state next time.
- State the missing condition plainly and ask for one concrete artifact: payload, log line, account id, screenshot, or exact command.

## Investigation Notes

Keep notes short and actionable:

```markdown
**Repro**
- Command:
- Failing assertion/error:
- Minimal scenario:

**Cause**
- File/function:
- Why it fails:

**Fix Verification**
- Before:
- After:
- Extra checks:
```

## Guardrails

- Do not "fix" a bug before proving what behavior is broken when a reasonable reproduction path exists.
- Do not broaden the test suite blindly to chase unrelated failures.
- Do not hide flaky behavior by loosening assertions unless the product contract itself changed.
- If the report is ambiguous, make the most likely assumption explicit and keep the reproduction easy to adjust.
