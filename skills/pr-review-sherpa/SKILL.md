---
name: pr-review-sherpa
description: Review pull requests and local diffs like a senior engineer. Use when Codex is asked to review code, inspect a PR, assess a diff before merge, find regressions, evaluate test coverage, or provide actionable file/line findings without implementing changes.
---

# PR Review Sherpa

Prioritize real defects over style commentary. A good review helps the author merge safer code with the fewest useful comments.

## Review Stance

Lead with findings. Focus on:

- Incorrect behavior or broken contracts.
- Regressions from changed control flow, data shape, auth, caching, concurrency, or persistence.
- Missing tests for risky behavior.
- Migration, rollout, compatibility, or operational risks.
- Security and privacy issues introduced by the diff.

Avoid broad rewrites, taste-only comments, and praise sections unless the user asks for them.

## Workflow

1. Establish the diff:
   - Inspect `git status -sb`.
   - Use `git diff --stat` and the relevant patch.
   - If reviewing a PR, compare against the PR base, not the working tree by accident.
2. Read intent:
   - Check PR title/body, issue links, commit messages, tests, and touched docs when available.
   - Infer the contract from nearby code if no description exists.
3. Inspect changed behavior:
   - Follow new branches, error paths, data transformations, public interfaces, and side effects.
   - Search for callers when signatures, schemas, routes, events, or config keys change.
   - Check whether tests cover the changed contract and important edge cases.
4. Validate when cheap:
   - Run narrow tests or static checks if they materially improve confidence.
   - Do not spend time running broad suites unless the diff is high-risk or the user asks.
5. Report only actionable items:
   - Each finding needs file, line, severity, impact, and a concrete correction direction.

## Finding Format

Use this structure:

```markdown
**Findings**
- `[P1] Title` - `path/to/file.ext:123`
  Explain the bug, the condition that triggers it, and why it matters. Point to the smallest fix direction.

**Open Questions**
- Question only when the answer changes review outcome.

**Checks**
- Command run or "Not run".
```

Severity:

- `P0`: breaks core production behavior, data loss, critical security.
- `P1`: likely user-facing bug, failed deploy, serious regression.
- `P2`: edge-case bug, missing important test, maintainability risk with clear cost.
- `P3`: minor cleanup; include sparingly.

If no issues are found, say so directly and mention residual risk or checks not run.

## Review Heuristics

- New optional field: check old callers, defaults, serialization, validation, and docs.
- New cache: check invalidation, key scope, auth/user separation, stale data behavior.
- New async path: check cancellation, retries, ordering, and partial failure.
- New DB query: check filtering, tenant boundaries, indexes, N+1 behavior, pagination.
- New UI state: check loading, empty, error, disabled, mobile, and accessibility states.
- New dependency: check bundle/runtime impact, license, and error handling.
- Deleted code: search for references and verify tests no longer depend on it.

## Guardrails

- Do not implement fixes during a review unless the user explicitly asks.
- Do not invent line numbers; inspect the file if line references matter.
- Do not bury the most severe finding under summary prose.
- Do not report style nits as bugs.
