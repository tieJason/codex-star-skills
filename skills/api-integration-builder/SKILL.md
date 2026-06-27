---
name: api-integration-builder
description: 构建稳健的第三方或内部 API 集成。用于 Codex 需要添加 API client、webhook handler、SDK wrapper、auth flow、pagination、retry、rate-limit 处理、typed error、mock、contract test 或外部服务集成文档的场景。
---

# API 集成构建器

把 API 当作不可靠边界来集成：输入有类型、错误显式、可观测性到位、安全重试，并用不依赖真实服务的测试兜住。

## 工作流程

1. 阅读事实来源：
   - 优先官方 API 文档、OpenAPI spec、SDK 文档或仓库现有 client。
   - 确认 auth、base URL、版本、pagination、rate limit、idempotency 和 webhook 签名。
   - 当前行为可能变化时，查官方文档。
2. 贴合本地架构：
   - 复用现有 HTTP client、配置、日志、指标、secret 和错误模式。
   - 如果仓库已有习惯，保持外部 DTO 与内部 domain model 分离。
   - 把集成代码放在相似 provider 附近。
3. 实现边界：
   - 集中管理 base URL、auth header、timeout 和 user agent。
   - 返回数据前解析并验证响应。
   - 让错误包含足够信息，方便调用方采取行动。
   - 明确处理 pagination 和 rate limit。
   - API 支持时，对不安全重试使用 idempotency key。
4. 避免真实依赖地测试：
   - 单测 request 构造和 response parsing。
   - 在 HTTP 边界 mock。
   - 有真实示例时加入 contract fixture。
   - 测 auth 失败、校验错误、rate limit、timeout 和 pagination。
5. 写好运维说明：
   - 必需 env vars 或 secrets。
   - webhook 设置和校验。
   - retry/rate-limit 行为。
   - 如何 replay 或调试失败调用。

## 错误模型

区分这些情况：

- 本地输入无效。
- 认证/授权失败。
- not found 或 conflict。
- rate limited。
- timeout 或网络失败。
- provider 校验错误。
- provider 服务端错误。
- 响应形状不符合预期。

除非项目已有这种模式，不要把原始 provider response 传遍全应用。

## Webhook

处理 webhook 时：

- 先验证签名，再信任字段。
- provider 支持时拒绝过期 timestamp。
- 通过 event id 保证幂等。
- 保存足够 event 元数据，方便 debug replay。
- 只有持久接收成功后，才返回 provider 期望的 success 响应。
- 测 invalid signature、duplicate event、unknown event type 和 valid event。

## 约束

- 不要记录 secret、token、完整 auth header 或敏感 payload。
- 除非仓库已有 gated 模式，不要把真实网络测试加入默认 CI。
- 没有 idempotency 机制时，不要重试非幂等操作。
- 不要静默吞 provider 错误；调用方需要可行动的失败模式。
- 文档模糊或过期时，记录假设，并让实现容易调整。
