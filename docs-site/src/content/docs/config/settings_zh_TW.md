---
title: 設定
description: 配置 sup CLI 設定
---

# 設定

配置 sup CLI 的行為與偏好。

## 配置文件

sup 將設定儲存在 `~/.config/sup/config.yaml`：

```yaml
source_workspace_id: 123
target_workspace_id: 456
output_format: table
theme: emerald
```

## 環境變數

```bash
# 身份驗證
export PRESET_API_TOKEN="您的 Token"
export PRESET_API_SECRET="您的 Secret"

# 輸出偏好
export SUP_OUTPUT_FORMAT="json"
export SUP_THEME="emerald"
```

## 指令

查看目前設定：
```bash
sup config show
```

設定特定配置值：
```bash
sup config set target-workspace-id 789
```

重設為預設值：
```bash
sup config reset
```
