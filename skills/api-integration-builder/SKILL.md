---
name: api-integration-builder
description: Build robust integrations with third-party or internal APIs. Use when Codex needs to add an API client, webhook handler, SDK wrapper, auth flow, pagination, retries, rate-limit handling, typed errors, mocks, contract tests, or documentation for an external service integration.
---

# API Integration Builder

Integrate APIs as unreliable boundaries: typed inputs, explicit errors, observability, retries where safe, and tests that do not depend on the live service.

## Workflow

1. Read the source of truth:
   - Prefer official API docs, OpenAPI specs, SDK docs, or existing clients in the repo.
   - Confirm auth method, base URL, versioning, pagination, rate limits, idempotency, and webhook signing.
   - Browse official docs when current behavior matters.
2. Fit the local architecture:
   - Reuse existing HTTP client, config, logging, metrics, secrets, and error patterns.
   - Keep external DTOs separate from internal domain models when the repo already does so.
   - Put integration code near similar providers.
3. Implement the boundary:
   - Centralize base URL, auth headers, timeout, and user agent.
   - Parse and validate responses before returning data.
   - Represent errors with enough detail for callers to act.
   - Handle pagination and rate limits deliberately.
   - Use idempotency keys for unsafe retries when the API supports them.
4. Test without live dependency:
   - Unit test request construction and response parsing.
   - Mock HTTP at the boundary.
   - Add contract fixtures from real examples when available.
   - Test auth failures, validation errors, rate limits, timeouts, and pagination.
5. Document operations:
   - Required env vars or secrets.
   - Webhook setup and verification.
   - Retry/rate-limit behavior.
   - How to replay or debug failed calls.

## Error Model

Make these cases distinguishable:

- Invalid local input.
- Authentication/authorization failure.
- Not found or conflict.
- Rate limited.
- Timeout or network failure.
- Provider validation error.
- Provider server error.
- Unexpected response shape.

Avoid returning raw provider responses across the app unless that is already the project pattern.

## Webhooks

For webhook handlers:

- Verify signature before parsing trusted fields.
- Reject stale timestamps when the provider supports them.
- Make processing idempotent by event id.
- Store enough event metadata to debug replay.
- Return the provider-expected success response only after durable acceptance.
- Test invalid signature, duplicate event, unknown event type, and valid event.

## Guardrails

- Do not log secrets, tokens, full auth headers, or sensitive payloads.
- Do not add live network tests to default CI unless the repo already has a gated pattern.
- Do not retry non-idempotent operations unless an idempotency mechanism exists.
- Do not silently swallow provider errors; callers need actionable failure modes.
- If docs are ambiguous or stale, capture the assumption and make the implementation easy to adjust.
