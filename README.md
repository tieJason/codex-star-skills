# Codex Star Skills

一组中文原创 Codex skills，覆盖代码库上手、bug 复现、PR 审查、测试加固、前端打磨、API 集成、安全轻审和从代码生成文档。

这个合集是索引用仓库。每个 skill 也会单独发布到一个独立 GitHub 仓库，方便单独 star、安装和维护。

## Skills

| Skill | 用途 |
| --- | --- |
| `repo-cartographer` | 梳理陌生仓库，找到架构入口、关键数据流和安全第一步。 |
| `bug-reproducer` | 把模糊 bug 变成最小复现、失败测试和修复验证。 |
| `pr-review-sherpa` | 像资深工程师一样审查 PR diff，优先找真实回归。 |
| `test-suite-hardener` | 增加有意义覆盖，减少 flaky，提升失败诊断质量。 |
| `frontend-polish-pass` | 打磨 UI，检查响应式、状态、可访问性和视觉质量。 |
| `api-integration-builder` | 构建稳健 API client、webhook、重试和类型化错误。 |
| `security-light-review` | 快速检查鉴权、注入、secret、隐私暴露等高影响风险。 |
| `docs-from-code` | 根据真实代码、测试、配置和命令输出生成准确文档。 |

## 安装合集

克隆仓库后，在仓库根目录运行：

```powershell
.\scripts\install.ps1
```

macOS 或 Linux:

```bash
./scripts/install.sh
```

默认安装到 `~/.codex/skills`。如需改位置，设置 `CODEX_HOME`：

```bash
CODEX_HOME=/path/to/codex ./scripts/install.sh
```

## 使用示例

```text
使用 $repo-cartographer 梳理这个仓库，并找出最安全的第一步改动。
使用 $bug-reproducer 复现这个问题，并添加一个回归测试。
使用 $frontend-polish-pass 打磨这个设置页，并检查移动端布局。
```

## 校验

```powershell
.\scripts\validate.ps1
```

校验会检查 skill 命名、frontmatter、必要文件和模板残留。

## License

MIT.
