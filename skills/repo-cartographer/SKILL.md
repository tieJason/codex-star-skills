---
name: repo-cartographer
description: Map unfamiliar codebases quickly before changing them. Use when Codex needs to orient in a new repository, explain architecture, identify entry points, trace a feature across files, produce an onboarding brief, or choose a low-risk implementation path before editing.
---

# Repo Cartographer

Turn an unknown repository into a small, useful map before touching code. Optimize for facts grounded in files, command output, and existing conventions.

## Workflow

1. Start with repository signals:
   - Run `rg --files` or the fastest local file lister.
   - Inspect root manifests, lockfiles, config files, package scripts, CI files, Docker files, and docs.
   - Run `git status -sb` to notice user work before edits.
2. Identify the system shape:
   - Runtime, framework, package manager, test runner, build tool, deployment surface.
   - Main entry points, route definitions, CLI commands, workers, migrations, and shared libraries.
   - Ownership boundaries such as apps, packages, modules, services, or layers.
3. Trace the requested area:
   - Search for user-facing words, route names, config keys, error messages, API paths, or domain objects.
   - Follow imports and callers until the data flow is clear enough to make a change.
   - Prefer call chains and contracts over broad summaries.
4. Produce a concise map:
   - What runs where.
   - Which files matter for the request.
   - Existing patterns to copy.
   - Likely tests and verification commands.
   - Risks, unknowns, and the recommended first change.

## Output Shape

For orientation-only requests, answer in this order:

```markdown
**Repo Map**
- Stack:
- Entry points:
- Important directories:
- Data flow:
- Test/build commands:

**For This Task**
- Files to inspect/change:
- Pattern to follow:
- Risks:
- First move:
```

For implementation requests, use the map internally, then implement once the path is clear. Mention only the parts of the map that explain the change.

## Search Heuristics

- Start narrow with exact strings from the user request.
- Search filenames before file contents when looking for likely modules.
- Search tests for behavior names; tests often reveal the intended contract faster than implementation.
- Inspect package scripts before inventing commands.
- Treat generated folders, vendored code, lockfiles, build outputs, and minified assets as background unless the task specifically targets them.

## Decision Rules

- If a repo has multiple apps, identify the app that owns the requested behavior before editing shared code.
- If two patterns exist, prefer the one closest to the touched module or newest comparable code.
- If the task affects a public API, persistence model, auth, billing, or data migration, broaden the map to include callers, tests, and rollout risk.
- If local docs contradict code, trust code and note the doc drift.
- If the worktree is dirty, distinguish user changes from your planned changes before editing.

## Verification

Choose the narrowest useful checks:

- Typecheck or lint for touched language/framework.
- Unit tests for the traced module.
- Integration/e2e tests when behavior crosses boundaries.
- Manual run or screenshot when the task is UI-facing.

If commands cannot run, report why and give the exact command that would verify the path.
