---
title: 同步配置
description: 配置多工作區同步操作
---

# 同步配置

為多工作區部署配置進階同步操作。

## 同步配置文件

建立一個 `sync_config.yml` 檔案，用來定義來源工作區、目標工作區以及資產選取標準。

### 完整範例

```yaml
source:
  workspace_id: 123
  assets:
    dashboards:
      selection: ids
      ids: [254, 255]
      include_dependencies: true
    charts:
      selection: all
      include_dependencies: true
    datasets:
      selection: mine
      include_dependencies: false
    databases:
      selection: ids
      ids: [1, 2]
      include_dependencies: false

target_defaults:
  overwrite: false
  include_dependencies: true
  jinja_context:
    environment: default
    company: ACME Corp
    region: us-east-1

targets:
  - workspace_id: 456
    name: staging
    overwrite: true
    jinja_context:
      environment: staging
      database_host: staging-db.example.com
  - workspace_id: 789
    name: production
    jinja_context:
      environment: production
      database_host: prod-db.example.com
```

## Schema 參考

### 來源配置 (Source Configuration)

| 欄位 | 類型 | 必填 | 說明 |
|-------|------|----------|-------------|
| `workspace_id` | 整數 | 是 | 要提取資產的來源工作區 ID |
| `assets` | 物件 | 是 | 資產類型與選取標準 |

### 資產類型 (Asset Types)

`source.assets` 下支援的資產類型：
- `charts` - 圖表配置
- `dashboards` - 儀表板佈局
- `datasets` - 資料集 / 資料表配置
- `databases` - 資料庫連線配置

每種資產類型都使用下方的 **資產選取 (Asset Selection)** Schema。

### 資產選取 (Asset Selection)

| 欄位 | 類型 | 預設值 | 說明 |
|-------|------|---------|-------------|
| `selection` | 字串 | `all` | 選取策略：`all` (全部)、`ids` (指定 ID)、`mine` (我的) 或 `filter` (過濾) |
| `ids` | 陣列 | null | 特定的資產 ID（當 `selection: ids` 時必填） |
| `include_dependencies` | 布林值 | `true` | 是否包含相關依賴資產（資料集、資料庫） |

### 目標預設值 (Target Defaults)

套用於所有目標的預設配置（除非被覆蓋）：

| 欄位 | 類型 | 預設值 | 說明 |
|-------|------|---------|-------------|
| `overwrite` | 布林值 | `false` | 推送操作的預設覆蓋行為 |
| `include_dependencies` | 布林值 | `true` | 預設的依賴包含行為 |
| `jinja_context` | 物件 | `{}` | 預設的 Jinja 範本變數 |

### 目標配置 (Target Configuration)

`targets` 陣列中的每個目標：

| 欄位 | 類型 | 必填 | 說明 |
|-------|------|----------|-------------|
| `workspace_id` | 整數 | 是 | 要推送資產的目標工作區 ID |
| `name` | 字串 | 否 | 此目標的人類可讀名稱 |
| `overwrite` | 布林值 | 否 | 覆蓋預設的 `overwrite` 設定 (null = 使用預設值) |
| `jinja_context` | 物件 | 否 | 目標特定的 Jinja 變數（會與預設值合併） |

**注意：** 目標特定的 `jinja_context` 數值會覆蓋 `target_defaults.jinja_context` 中的同名變數。

## 選取策略 (Selection Strategies)

### 全部資產 (All Assets)
提取指定類型的所有資產：
```yaml
charts:
  selection: all
  include_dependencies: true
```

### 依 ID 選取 (By IDs)
依據 ID 提取特定資產：
```yaml
dashboards:
  selection: ids
  ids: [254, 255, 256]
  include_dependencies: true
```

### 僅限我的資產 (My Assets Only)
僅提取您擁有的資產：
```yaml
datasets:
  selection: mine
  include_dependencies: false
```

### 使用過濾器 (With Filters)
提取符合過濾條件的資產：
```yaml
charts:
  selection: filter
  # 注意：過濾器實作尚在進行中
```

## Jinja 範本化 (Jinja Templating)

在資產配置中使用 Jinja 範本：

```sql
-- 在您的 SQL 查詢中
SELECT * FROM {{ environment }}_sales_data
WHERE company = '{{ company }}'
```

## 執行同步

```bash
# 試執行 (Dry run) 以預覽變更
sup sync run ./sync_config.yml --dry-run

# 僅從來源提取 (Pull)
sup sync run ./sync_config.yml --pull-only

# 僅推送至目標 (Push)
sup sync run ./sync_config.yml --push-only

# 完整同步（先提取後推送）
sup sync run ./sync_config.yml
```
