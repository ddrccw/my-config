<!--
Authorship: Human-AI collaboration
AI-Assisted-By: OpenAI Codex
Updated: 2026-09-06
-->

# my-config 仓库约定

NAS 上的 Codex 同时遵循全局指引所引用的共享 `AGENTS.md` 中的「NAS Codex 通用仓库约定」；来源标注、日期和 Git 操作要求统一在那里维护。本文件补充 my-config 专属要求。

- 本仓库存放在 GitHub，所有入库内容均按公开信息处理。配置、脚本、文档及提交信息不得包含密码、访问令牌、API 密钥、私钥、配对码或其他敏感信息；示例使用占位符。
- 敏感值通过环境变量或仓库外的本机配置提供。提交前检查暂存区，不能仅依赖忽略规则；发现敏感信息时不得提交。
- 尽可能共用根目录配置，优先使用能力检测和本机覆盖；仅在无法共用时引入平台专属配置目录（如 platforms/nas）。
- Zsh 本地环境配置默认使用 `~/.zshenv.local`，由共享 `.zshenv` 加载；登录及交互配置分别使用 `~/.zprofile.local` 和 `~/.zshrc.local`。`~/.zsh_profile` 待淘汰，仅在 `.zshenv.local` 不存在时兼容加载；迁移后移除旧文件。这些本地文件不上传 Git，不将其中的敏感值复制到仓库。
