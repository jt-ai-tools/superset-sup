---
title: 介紹
description: 開始使用 sup CLI
---

# sup CLI 介紹

`sup` 是一款為 Apache Superset 與 Preset 工作區打造的美觀、現代化命令列介面。它提供類 Git 的工作流程來管理您的分析資產。

## 為什麼選擇 sup？

- **熟悉的介面**：類 Git 的指令（pull、push、sync）。
- **精美的輸出**：帶有翡翠綠品牌設計的 Rich 表格。
- **企業級功能**：跨工作區同步、JWT 身份驗證。
- **類型安全**：使用 Pydantic 構建，確保可靠性。
- **快速高效**：針對效能優化。

## 核心概念

### 工作區 (Workspaces)
工作區是指您的 Superset 或 Preset 執行個體。您可以處理多個工作區，並在它們之間同步資產。

### 資產 (Assets)
資產是指您的 Superset 資源：
- **資料庫 (Databases)**：資料來源連線。
- **資料集 (Datasets)**：虛擬資料表與指標。
- **圖表 (Charts)**：視覺化呈現。
- **儀表板 (Dashboards)**：圖表的集合。
- **查詢 (Queries)**：已儲存的 SQL 查詢。

### 工作流程 (Workflows)
sup 支援三種主要工作流程：
1. **Pull (提取)**：從工作區將資產下載至本地檔案。
2. **Push (推送)**：將本地資產上傳至工作區。
3. **Sync (同步)**：在多個工作區之間協調資產。

## 下一步

- [安裝 sup CLI](../installation_zh_TW/)
- [快速上手指南](../quick-start_zh_TW/)
- [瀏覽指令](../commands/workspace_zh_TW/)
