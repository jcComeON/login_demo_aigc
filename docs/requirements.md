# 登录功能需求

## 目标

构建一个前后端分离的登录演示项目。

- 后端：Java Spring Boot，位于 `src/`
- 前端：React，位于 `frontend/`

## 初始功能需求

- 用户可以在 React 前端提交用户名和密码。
- 前端调用后端登录 API。
- 后端校验请求体。
- 后端返回清晰的成功或失败响应。
- 前端展示登录成功和登录失败状态。

## 安全要求

- 不存储明文密码。
- 不提交真实密钥。
- 不记录密码或 Token 日志。
- 在认证逻辑运行前完成后端输入校验。
- 返回通用认证失败信息，避免泄露账号是否存在等细节。

## 建议 API 契约

```http
POST /api/auth/login
Content-Type: application/json
```

请求：

```json
{
  "username": "demo",
  "password": "password"
}
```

成功响应：

```json
{
  "success": true,
  "message": "Login successful"
}
```

失败响应：

```json
{
  "success": false,
  "message": "Invalid username or password"
}
```

## 实现说明

- 如果暂时没有数据库，可以先使用简单的演示用户。
- 演示用户配置应保持隔离，方便后续替换为真实用户存储。
- 后端测试应覆盖登录成功、密码错误、缺少用户名、缺少密码。
- React 项目初始化后，应补充前端测试。
