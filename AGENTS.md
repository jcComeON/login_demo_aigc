# Codex 开发指南

本项目采用前后端分离架构。

- 后端：Java Spring Boot，位于 `src/`
- 前端：React，位于 `frontend/`
- Agent 共享文档：`docs/`
- 自动化脚本：`scripts/`

## Codex 角色

Codex 是代码实现 Agent，负责开发代码、更新测试、运行验证命令，并处理 Claude Code 提出的必改审计意见。

## 工作流程

1. 阅读 `docs/requirements.md`。
2. 如果 `docs/review.md` 存在，优先处理其中的必改问题。
3. 围绕登录功能做最小且完整的一组代码修改。
4. 为变更的行为新增或更新测试。
5. 运行相关验证命令。
6. 保持仓库处于可审计、可提交的状态。

## 验证命令

后端：

```powershell
.\gradlew.bat test
```

前端，当 `frontend/package.json` 存在时：

```powershell
npm --prefix frontend install
npm --prefix frontend test
npm --prefix frontend run build
```

## 开发规则

- 认证逻辑必须清晰、显式，便于审计。
- 不得提交密钥、令牌、密码或私钥。
- 在后端边界处校验请求数据。
- 永远不要存储明文密码。
- 优先沿用项目已有约定，避免随意引入新依赖。
- 只有在验证命令已运行，或无法运行的原因已记录时，才能说明工作完成。
- 覆盖其他 Agent 修改过的文件前，必须先读取当前文件内容。
