---
name: security-light-review
description: 对代码改动或功能做实用的轻量安全审查。用于 Codex 需要检查 auth、authorization、secret、injection、unsafe file handling、SSRF、XSS、CSRF、webhook、依赖风险、隐私暴露或其他高影响安全问题，但不需要完整正式审计的场景。
---

# 安全轻审

快速找出可能真实发生、影响较高的安全问题。这不是正式审计，而是聚焦的工程审查，应产出具体修复或风险说明。

## 工作流程

1. 定义边界：
   - 改了什么？
   - 哪些输入跨越信任边界？
   - 哪些用户、租户、角色或服务能访问？
   - 涉及哪些敏感数据、凭据、文件或资金流？
2. 追踪危险路径：
   - request parsing、authn/authz、validation、storage、outbound request、rendering、logging 和 background job。
   - 搜索仓库相似模式，复用已有防护。
3. 检查下面的风险清单。
4. 按可利用性和影响报告问题。
5. 只有用户要求实现，或原任务包含修复时，才动手修。

## 风险清单

- Auth bypass：缺 session 检查、信任客户端 user id、token 校验薄弱。
- Authorization：租户越界、角色混淆、对象级访问控制缺口。
- Injection：SQL/NoSQL/LDAP/command/template 拼接注入。
- XSS：未转义 HTML、不安全 markdown、用户可控 URL、危险 DOM sink。
- CSRF/CORS：浏览器可触达的危险状态变更接口。
- SSRF：用户可控 URL 访问内网或 metadata service。
- 文件处理：路径穿越、不安全解压、无限制上传、可执行内容。
- Secrets：提交密钥、日志含 token、URL 含 secret、env 暴露过宽。
- Webhooks：缺签名验证、无 replay 防护、重复处理。
- Crypto：自定义加密、弱随机数、硬编码 key、不安全密码存储。
- 依赖：新增包有高风险 install script、无人维护、传递影响过大。
- 隐私：过度收集 PII、analytics/log/error 泄露、缺删除路径。

## 问题格式

```markdown
**问题**
- `[High] 标题` - `path/to/file.ext:123`
  攻击路径、影响、受影响用户/数据、具体修复方向。

**剩余风险**
- 未覆盖内容或需要更深审计的地方。

**检查**
- 已运行命令或人工检查。
```

严重级别：

- `Critical`：可能导致系统被控、数据丢失、auth bypass 或 RCE。
- `High`：现实可利用且数据/权限影响显著。
- `Medium`：受限利用、防护缺口或重要加固项。
- `Low`：低概率问题或卫生改进。

## 约束

- 不要提供针对真实第三方目标的利用 payload。
- 不要声称完成了正式审计。
- 没有本代码库中可信路径的问题，不要报告成理论漏洞。
- 不要为了简化配置把 secrets 移进代码。
- 如果安全建议依赖当前框架行为，查官方文档确认。
