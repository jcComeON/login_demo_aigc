# Claude Code 审计结果

## 结论

APPROVED

## 变更概览

本次变更实现了前后端分离的登录演示功能：

- 后端：新增 Spring Boot 登录接口、认证服务、请求/响应 record，并使用 PBKDF2 哈希校验演示用户密码。
- 前端：新增 React + TypeScript + Vite 登录表单、API 客户端、样式和组件测试。
- 脚本：更新 `scripts/agent-dev.ps1`，兼容本机 Codex CLI 路径并支持自动化执行。
- 配置：更新 `.gitignore`，排除前端依赖目录和构建产物。

## 审计结论

变更质量良好，安全实践符合当前演示功能范围。密码使用 `PBKDF2WithHmacSHA256` 哈希存储，比较使用 `MessageDigest.isEqual()`，错误信息不泄露用户是否存在，前后端 API 契约一致。未发现必改问题。

## 可选建议

- `src/main/java/com/example/login_demo_aigc/AuthController.java`：Controller 和 Service 当前为 package-private，Spring 可以正常发现；如果项目后续引入 AOP 或代理，可以考虑改为 `public` 以贴近常见约定。
- `src/test/java/com/example/login_demo_aigc/AuthControllerTests.java`：可补充空请求体、仅空格用户名、不存在用户名等边界测试。
- `frontend/src/App.test.tsx`：可补充 fetch rejection 时的网络异常提示测试。
- `scripts/agent-dev.ps1`：`--dangerously-bypass-approvals-and-sandbox` 适合当前自动化开发流程，但应只在受控本地项目中使用。

## 验证情况

已运行：

```powershell
.\gradlew.bat test
npm --prefix frontend test
npm --prefix frontend run build
```

结果：

- 后端测试通过。
- 前端测试通过：1 个测试文件，4 个测试通过。
- 前端生产构建通过。
