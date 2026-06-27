# Codex Star Skills

High-leverage Codex skills for code review, debugging, documentation, frontend polish, API work, research writing, PDFs, Office files, transcription, and GitHub workflows.

The collection is designed like a toolbox: each skill is small enough to load quickly, specific enough to trigger at the right time, and practical enough to use on real projects without extra ceremony.

## Skills

| Skill | Use it for |
| --- | --- |
| `repo-cartographer` | Map unfamiliar repositories and choose a safe first change. |
| `bug-reproducer` | Turn vague bugs into minimal reproductions and regression tests. |
| `pr-review-sherpa` | Review PRs and local diffs for real regressions. |
| `test-suite-hardener` | Add meaningful tests and reduce flaky behavior. |
| `frontend-polish-pass` | Improve UI polish, responsiveness, states, and visual QA. |
| `api-integration-builder` | Build robust API clients, webhooks, retries, and typed errors. |
| `security-light-review` | Run practical security checks on code changes. |
| `docs-from-code` | Generate accurate docs from code, tests, and configs. |
| `content-research-writer` | Research, outline, draft, and cite long-form writing. |
| `gh-address-comments` | Fetch and address actionable GitHub PR comments. |
| `notion-research-documentation` | Research across Notion and synthesize structured docs. |
| `officecli` | Create, inspect, and edit Word, Excel, and PowerPoint files. |
| `pdf` | Read, create, render, inspect, and modify PDFs. |
| `transcribe` | Transcribe audio/video with diarization support. |

## Install

Clone the repo, then run the installer from the repository root:

```powershell
.\scripts\install.ps1
```

On macOS or Linux:

```bash
./scripts/install.sh
```

By default, skills are copied into `~/.codex/skills`. Set `CODEX_HOME` to install somewhere else:

```bash
CODEX_HOME=/path/to/codex ./scripts/install.sh
```

## Usage

Invoke a skill explicitly in Codex:

```text
Use $repo-cartographer to map this repository before we implement the feature.
Use $bug-reproducer to reproduce this issue and add a regression test.
Use $frontend-polish-pass to polish this settings page and verify mobile layout.
```

Codex can also trigger skills implicitly when the description matches the task.

## Repository Layout

```text
skills/
  <skill-name>/
    SKILL.md
    agents/openai.yaml
scripts/
  install.ps1
  install.sh
  validate.ps1
  validate.sh
```

## Design Notes

These skills follow a few rules that make them useful in daily work:

- Keep `SKILL.md` concise and procedural.
- Put trigger conditions in frontmatter descriptions.
- Prefer existing project patterns over invented abstractions.
- Verify with real commands when the task touches code or generated files.
- Keep output grounded in files, tests, docs, and source material.

## Validate

Run the included validation helper:

```powershell
.\scripts\validate.ps1
```

It checks skill naming, frontmatter, required files, and common template leftovers.

## License

MIT. Some copied upstream skills include their own `LICENSE.txt`; keep those notices with the corresponding skill.
