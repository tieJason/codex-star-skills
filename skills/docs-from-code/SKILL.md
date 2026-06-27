---
name: docs-from-code
description: Generate or update accurate documentation from the current codebase. Use when Codex needs to write README sections, API docs, runbooks, architecture notes, migration guides, troubleshooting docs, or onboarding material grounded in actual source code and verified commands.
---

# Docs From Code

Write docs that match the repository, not docs that sound plausible. Treat code, tests, configs, and command output as primary sources.

## Workflow

1. Identify the doc target:
   - README, API reference, runbook, architecture note, tutorial, migration guide, changelog entry, or troubleshooting section.
   - Intended reader: new contributor, operator, app developer, end user, maintainer, or reviewer.
2. Gather facts from the repo:
   - Manifests and scripts.
   - Config and environment examples.
   - Entry points, routes, CLIs, public exports, tests, and examples.
   - Existing docs for tone and structure.
3. Verify commands when reasonable:
   - Help commands, test commands, build commands, CLI examples, or generated docs.
   - If a command cannot be run, mark it as unverified.
4. Write only supported claims:
   - Prefer concrete file paths, command names, option names, and behavior.
   - Avoid generic marketing language.
   - Keep setup steps copy-pasteable.
5. Cross-check:
   - Ensure names, paths, flags, env vars, defaults, and examples match code.
   - Search for stale duplicated docs if updating behavior.

## Documentation Types

### README

Include only the parts the project needs:

- What it is.
- Quick start.
- Install/setup.
- Common commands.
- Configuration.
- Usage examples.
- Testing/development.
- Deployment or operations when relevant.

### API Docs

- Document request/response shapes from schemas, handlers, tests, or OpenAPI.
- Include auth, pagination, errors, rate limits, and examples.
- Mention versioning and compatibility if visible in code.

### Runbooks

- Start with symptoms and impact.
- Provide diagnosis commands.
- Explain safe remediation steps.
- Include rollback and escalation criteria.
- Avoid requiring tribal knowledge.

### Architecture Notes

- Show components and data flow.
- Explain why boundaries exist when code reveals intent.
- Link to files that anchor the explanation.
- Call out known constraints and extension points.

## Style Rules

- Be concise and operational.
- Put the fastest successful path first.
- Use headings that match user tasks.
- Prefer commands in fenced code blocks.
- Avoid documenting internal implementation details unless maintainers need them.
- Mark assumptions and unverified steps clearly.

## Guardrails

- Do not invent install commands, env vars, endpoints, or flags.
- Do not overwrite existing docs tone with a completely different style unless asked.
- Do not include secrets from local files or logs.
- Do not cite generated files as the only source if source files are available.
- If docs and code disagree, update docs to match code and mention the drift in the final response.
