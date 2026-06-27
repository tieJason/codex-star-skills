---
name: frontend-polish-pass
description: 改进已有前端界面的实现质量并做视觉验证。用于 Codex 被要求让界面更精致、更响应式、更可访问、更少混乱、更符合设计系统，或需要通过截图和浏览器检查验证 UI 改动的场景。
---

# 前端打磨 Pass

把打磨当作产品工作：布局、层级、状态、动效、可访问性和响应式都要服务于用户任务。

## 工作流程

1. 学习 UI 系统：
   - 查看现有组件、间距、颜色、字体、图标和状态模式。
   - 判断应用类型：dashboard、editor、marketing site、game、docs、commerce 或内部工具。
   - 复用现有组件库和图标库。
2. 改进真实流程：
   - 优先处理用户点名的屏幕或路径。
   - 让高密度工具可扫读、可高效操作。
   - 让 landing 或内容页在视觉上贴合主题。
   - 补齐 loading、empty、error、disabled、hover/focus、mobile 等状态。
3. 稳定布局：
   - 使用响应式约束、grid/flex、稳定 aspect-ratio、min/max width。
   - 确保按钮、卡片、tab、sidebar、toolbar 中的文字不溢出。
   - 避免动态内容导致 layout shift。
4. 视觉验证：
   - 需要时启动应用。
   - 工具可用时，截 desktop 和 mobile 宽度的图。
   - 检查关键交互，不只看首屏。
   - 可用时检查 console error。

## 设计启发

- 匹配场景：运营工具应冷静、密集；创作应用可以更有表现力。
- 使用熟悉控件：常用工具用 icon button，视图用 tabs，二元设置用 toggle，数字用 slider/input，选项用 menu。
- 卡片只用于重复项、modal 和被框定的工具；避免卡片套卡片。
- 需要视觉资产的网站应使用真实或生成的 bitmap 图片。
- 标题大小要匹配容器。
- 避免单一色系和装饰性背景 blob。
- 保证对比度、focus 状态、label 和键盘可达性。

## 视觉 QA 清单

- desktop 下没有奇怪空白或重叠。
- mobile 下没有非预期横向滚动。
- 长 label 和真实数据能放下。
- empty/error/loading 状态完整。
- 按钮和输入有 hover、focus、disabled、active 反馈。
- 图标与文字视觉对齐。
- 图片和 canvas 非空、构图正确。
- 改动路径没有 console error。

## 输出

完成后总结：

- 视觉和行为改了什么。
- 检查过哪些 viewport 或交互。
- 还剩哪些设计风险或有用资产缺口。

如果不能截图，说明缺少的手动/浏览器检查，并尽量运行代码层检查。
