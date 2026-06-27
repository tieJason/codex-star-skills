---
name: security-light-review
description: Perform a practical lightweight security review of code changes or features. Use when Codex needs to inspect auth, authorization, secrets, injection, unsafe file handling, SSRF, XSS, CSRF, webhooks, dependency risk, privacy exposure, or other high-impact security issues without a full formal audit.
---

# Security Light Review

Find likely, high-impact security problems quickly. This is not a formal audit; it is a focused engineering review that should produce concrete fixes or risk notes.

## Workflow

1. Define the boundary:
   - What changed?
   - What inputs cross trust boundaries?
   - Which users, tenants, roles, or services can reach it?
   - What sensitive data, credentials, files, or money movement is involved?
2. Trace the dangerous paths:
   - Request parsing, authn/authz, validation, storage, outbound requests, rendering, logging, and background jobs.
   - Search for similar patterns in the repo to match established defenses.
3. Check the risk list below.
4. Report findings by exploitability and impact.
5. Implement fixes only when the user asks for implementation or the original request includes fixing.

## Risk Checklist

- Auth bypass: missing session checks, trusting client-supplied user ids, weak token validation.
- Authorization: tenant breakout, role confusion, object-level access control gaps.
- Injection: SQL/NoSQL/LDAP/command/template injection through string concatenation.
- XSS: unescaped HTML, unsafe markdown, user-controlled URLs, dangerous DOM sinks.
- CSRF/CORS: unsafe state-changing endpoints exposed to browsers.
- SSRF: user-controlled URLs reaching internal networks or metadata services.
- File handling: path traversal, unsafe archive extraction, unrestricted uploads, executable content.
- Secrets: committed keys, logs with tokens, secrets in URLs, overly broad env exposure.
- Webhooks: missing signature verification, no replay protection, duplicate processing.
- Crypto: custom crypto, weak randomness, hard-coded keys, insecure password storage.
- Dependencies: new package with risky install scripts, abandoned package, broad transitive impact.
- Privacy: excessive PII collection, leaks in analytics/logs/errors, missing deletion path.

## Finding Format

```markdown
**Findings**
- `[High] Title` - `path/to/file.ext:123`
  Attack path, impact, affected users/data, and concrete fix direction.

**Residual Risk**
- What was not covered or needs deeper audit.

**Checks**
- Commands or manual inspection performed.
```

Severity:

- `Critical`: likely compromise, data loss, auth bypass, remote code execution.
- `High`: realistic exploit with significant data or privilege impact.
- `Medium`: constrained exploit, defense gap, or important hardening.
- `Low`: low-likelihood issue or hygiene improvement.

## Guardrails

- Do not provide exploit payloads against real third-party targets.
- Do not claim a formal audit was completed.
- Do not flag theoretical issues without a plausible path in this codebase.
- Do not move secrets into code to simplify configuration.
- If security advice depends on current framework behavior, verify against official docs.
