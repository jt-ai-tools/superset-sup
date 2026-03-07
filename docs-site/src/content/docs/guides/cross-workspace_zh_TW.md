---
title: 跨工作區同步
description: 學習如何在多個工作區之間同步資產
---

# 跨工作區同步

跨工作區同步允許您在不同的 Superset 或 Preset 工作區之間移動資產，這非常適合「從開發環境到生產環境」的工作流程。

## 基本工作流程

### 1. 設定來源與目標工作區

```bash
# 設定來源工作區
sup workspace use 123

# 設定目標工作區
sup workspace set-target 456
```

### 2. 從來源提取 (Pull)

```bash
# 提取特定儀表板
sup dashboard pull --ids 789,790

# 提取包含依賴關係的圖表
sup chart pull --mine --include-deps
```

### 3. 推送至目標 (Push)

```bash
# 推送至目標工作區
sup dashboard push --workspace-id 456 --force
```

## 進階同步配置

### 多目標同步 (Multi-Target Sync)

建立適用於多個目標的同步配置：

```yaml
# sync_config.yml
source:
  workspace_id: 123
  assets:
    dashboards:
      selection: ids
      ids: [789, 790]
    charts:
      selection: all

targets:
  - workspace_id: 456
    name: staging
  - workspace_id: 789
    name: production
```

執行同步：

```bash
sup sync run ./sync_config.yml
```

## 最佳實踐

1. **務必在推送前先提取 (Pull before push)**，以確保您擁有最新版本。
2. **使用 --dry-run** 在套用變更前先進行預覽。
3. 對您的 **同步配置進行版本控制**，以確保可重複性。
4. 在推送到生產環境之前，先在 **預發布 (Staging) 環境進行測試**。

## 常見問題

### 依賴關係衝突

推送具備依賴關係的資產時：
- 資料集必須在圖表之前存在。
- 資料庫必須在資料集之前存在。
- 使用 `--include-deps` 來自動處理依賴關係。

### 權限錯誤

確保您的 API 憑證具備：
- 來源工作區的讀取權限。
- 目標工作區的寫入權限。
- 資料庫連線的管理員權限。
