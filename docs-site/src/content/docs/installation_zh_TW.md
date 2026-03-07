---
title: 安裝
description: 如何安裝 sup CLI
---

# 安裝

## 系統需求

- Python 3.8 或更高版本
- pip 或 uv 套件管理器

## 從 PyPI 安裝

```bash
pip install superset-sup
```

或者使用 uv (速度更快)：

```bash
uv pip install superset-sup
```

## 從原始碼安裝

```bash
git clone https://github.com/preset-io/superset-sup.git
cd superset-sup
pip install -e .
```

## 驗證安裝

```bash
sup --version
```

## 身份驗證設定

### Preset.io

請從 [https://preset.io/settings/api-tokens](https://preset.io/settings/api-tokens) 取得您的 API 憑證。

```bash
export PRESET_API_TOKEN="您的 Token"
export PRESET_API_SECRET="您的 Secret"
```

### 自行託管的 Superset (Self-hosted)

```bash
export SUPERSET_URL="https://您的-superset.com"
export SUPERSET_USERNAME="admin"
export SUPERSET_PASSWORD="您的密碼"
```

## 下一步

- [快速上手指南](../quick-start_zh_TW/)
- [瀏覽指令](../commands/workspace_zh_TW/)
