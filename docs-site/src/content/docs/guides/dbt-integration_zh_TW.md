---
title: dbt 整合
description: 將 dbt 模型與 Superset 資料集同步
---

# dbt 整合

sup CLI 可以將您的 dbt 模型與 Superset 資料集同步，保持您的分析技術棧 (Analytics Stack) 同步運作。

## 準備工作

- dbt Core 或 dbt Cloud 專案。
- 具備資料庫連線的 Superset/Preset 工作區。

## dbt Core 整合

### 設定

配置 dbt 路徑：

```bash
sup config set dbt-project-dir /您的/dbt/專案/路徑
sup config set dbt-profiles-dir ~/.dbt
```

### 將模型同步至資料集

```bash
# 同步所有模型
sup dataset sync-dbt

# 同步特定模型
sup dataset sync-dbt --models staging.sales,marts.revenue

# 使用自定義目標 (Target)
sup dataset sync-dbt --target production
```

## dbt Cloud 整合

### 設定

配置 dbt Cloud 憑證：

```bash
sup config set dbt-cloud-account-id 12345
sup config set dbt-cloud-project-id 67890
sup config set dbt-cloud-job-id 11111
sup config set dbt-cloud-api-token "您的 Token"
```

### 從 dbt Cloud 同步

```bash
# 從最新執行記錄 (Latest Run) 同步
sup dataset sync-dbt-cloud

# 從特定執行記錄 (Specific Run) 同步
sup dataset sync-dbt-cloud --run-id 123456
```

## 對應配置 (Mapping Configuration)

建立一個 `dbt_mapping.yml` 檔案：

```yaml
models:
  staging.customers:
    superset_dataset: "STG_CUSTOMERS"
    metrics:
      - name: customer_count
        expression: COUNT(DISTINCT customer_id)
      - name: total_revenue
        expression: SUM(revenue)
    
  marts.sales:
    superset_dataset: "SALES_FACT"
    time_column: order_date
    dimensions:
      - customer_id
      - product_id
      - region
```

## Exposures

從 Superset 生成 dbt exposures：

```bash
# 生成 exposures YAML
sup chart export-exposures > models/exposures.yml

# 包含在 dbt 專案中
sup chart export-exposures --output models/exposures/superset.yml
```

## 最佳實踐

1. 在 dbt 模型與 Superset 資料集之間 **使用一致的命名**。
2. 在 dbt 中 **記錄指標 (Metrics)** 並同步至 Superset。
3. 對您的 **對應配置 (Mapping Configuration)** 進行版本控制。
4. 在同步至生產環境前，先在 **預發布 (Staging) 環境測試**。
5. **使用 CI/CD** 在 dbt 執行後自動觸發同步。
