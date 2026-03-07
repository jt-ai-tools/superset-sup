---
title: 身份驗證
description: sup CLI 的身份驗證方法
---

# 身份驗證

sup CLI 支援多種身份驗證方法來連接至 Superset 與 Preset 工作區。

## Preset.io 身份驗證

### API Token (推薦)

請從 [Preset 設定 (Preset Settings)](https://preset.io/settings/api-tokens) 取得您的 API 憑證。

```bash
export PRESET_API_TOKEN="您的 Token"
export PRESET_API_SECRET="您的 Secret"
```

### JWT Token

對於擁有 JWT 存取權限的進階使用者：

```bash
export PRESET_JWT_TOKEN="您的 JWT Token"
```

## 自行託管的 Superset (Self-hosted)

### 使用者名稱 / 密碼

```bash
export SUPERSET_URL="https://您的-superset.com"
export SUPERSET_USERNAME="admin"
export SUPERSET_PASSWORD="您的密碼"
```

### 工作階段 Token (Session Token)

如果您已有現有的工作階段：

```bash
export SUPERSET_SESSION_TOKEN="您的 Session Token"
```

## 憑證儲存

sup 可以安全地儲存憑證：

```bash
# 儲存憑證
sup auth login

# 清除已儲存的憑證
sup auth logout
```

## 測試身份驗證

驗證您的身份驗證是否成功：

```bash
sup workspace list
```

如果身份驗證成功，您將會看到可用的工作區列表。
