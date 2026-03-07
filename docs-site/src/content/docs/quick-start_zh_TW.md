---
title: 快速上手
description: 在幾分鐘內開始使用 sup CLI
---

# 快速上手

## 1. 設定您的工作區

首先，列出可用的工作區：

```bash
sup workspace list
```

設定您目前要使用的主要工作區：

```bash
sup workspace use 123
```

## 2. 探索您的資產

列出您的圖表：

```bash
sup chart list --mine
```

列出儀表板：

```bash
sup dashboard list --limit 10
```

## 3. 在本地端提取資產 (Pull)

提取包含依賴關係的圖表：

```bash
sup chart pull --ids 456,789
```

這會在本地端建立一個 `./assets/` 目錄，其中包含您的圖表及其相應的依賴關係。

## 4. 執行 SQL 查詢

直接執行查詢：

```bash
sup sql "SELECT COUNT(*) FROM orders WHERE created_at > '2024-01-01'"
```

匯出結果：

```bash
sup sql "SELECT * FROM customers" --json > customers.json
```

## 5. 推送至另一個工作區 (Push)

設定目標工作區：

```bash
sup workspace set-target 456
```

推送您的圖表：

```bash
sup chart push --force
```

## 常見工作流程

### 從開發環境到生產環境

```bash
# 從開發環境提取 (Pull)
sup workspace use dev-workspace
sup dashboard pull --ids 123

# 推送至生產環境 (Push)
sup workspace use prod-workspace
sup dashboard push
```

### 備份資產

```bash
sup chart pull --all
sup dashboard pull --all
git add assets/
git commit -m "Backup analytics assets"
```

## 下一步

- [跨工作區同步指南](../guides/cross-workspace_zh_TW/)
- [指令參考](../commands/workspace_zh_TW/)
