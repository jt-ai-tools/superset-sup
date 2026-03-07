---
title: 多資產工作流程
description: 管理複雜的多資產依賴關係
---

# 多資產工作流程

瞭解如何管理涉及多種具備依賴關係之資產類型的複雜工作流程。

## 瞭解依賴關係

Superset 資產具有階層式的依賴關係：

```
資料庫 (Databases)
    ↓
資料集 (Datasets)
    ↓
圖表 (Charts)
    ↓
儀表板 (Dashboards)
```

## 提取具備依賴關係的資產 (Pull)

### 提取儀表板及其所有內容

```bash
# 提取儀表板及其所有依賴關係
sup dashboard pull --ids 123 --include-deps

# 這會提取：
# - 儀表板 123
# - 儀表板中包含的所有圖表
# - 圖表使用的所有資料集
# - 資料庫連線（僅限元數據）
```

### 選擇性依賴提取

```bash
# 提取圖表，但不包含資料集
sup chart pull --ids 456,789 --no-deps

# 提取資料集，但不包含資料庫配置
sup dataset pull --mine --skip-databases
```

## 多資產同步工作流程

### 1. 建立同步配置

```yaml
# multi-asset-sync.yml
source:
  workspace_id: 123
  assets:
    dashboards:
      selection: ids
      ids: [100, 101]
      include_dependencies: true
    charts:
      selection: ids
      ids: [200, 201, 202]
      include_dependencies: true
    datasets:
      selection: all
      include_dependencies: false

targets:
  - workspace_id: 456
    name: target-workspace
```

### 2. 預覽變更

```bash
sup sync run multi-asset-sync.yml --dry-run
```

### 3. 執行同步

```bash
sup sync run multi-asset-sync.yml
```

## 處理衝突

### 資料集名稱衝突

當資料集發生命名衝突時：

```bash
# 在推送時重新命名
sup dataset push --rename-pattern "DEV_{name}"

# 強制覆蓋
sup dataset push --force --overwrite
```

### 圖表擁有權

保留或變更擁有權：

```bash
# 保留原始擁有者
sup chart push --preserve-owner

# 指派給目前使用者
sup chart push --assign-to-me
```

## 批次操作

### 匯出所有內容

```bash
# 從工作區匯出所有資產
sup workspace export --all --output ./backup/

# 匯出特定類型
sup workspace export --types charts,dashboards --output ./export/
```

### 匯入套件 (Bundle)

```bash
# 匯入匯出的套件
sup workspace import ./backup/ --workspace-id 456
```

## 依賴解析

sup 會依據正確的順序自動解析依賴關係：

1. 首先建立/更新 **資料庫 (Databases)**。
2. 建立包含資料庫參照的 **資料集 (Datasets)**。
3. 建立包含資料集參照的 **圖表 (Charts)**。
4. 建立包含圖表參照的 **儀表板 (Dashboards)**。

## 最佳實踐

1. **務必先使用 --dry-run** 來預覽變更。
2. 對您的同步配置進行 **版本控制**。
3. 在同步配置中 **記錄依賴關係**。
4. **使用標籤 (Tags)** 來組織相關資產。
5. 在執行生產環境同步前，先在 **預發布 (Staging) 環境測試**。
6. **監控日誌** 以查看依賴關係警告。

## 範例：完整遷移

```bash
# 1. 從來源導出
sup workspace use source-workspace
sup workspace export --all --output ./migration/

# 2. 檢視導出的資產
ls -la ./migration/assets/

# 3. 匯入至目標
sup workspace use target-workspace
sup workspace import ./migration/ --force

# 4. 驗證遷移結果
sup dashboard list --limit 10
sup chart list --limit 10
```
