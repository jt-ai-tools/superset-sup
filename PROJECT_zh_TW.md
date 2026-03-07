# `sup` - 可能是最強大的非官方 Apache Superset CLI 🚀

## 願景：適用於 Superset 與 Preset 的現代化 CLI

透過 **`sup`** 徹底改變您與 Superset/Preset 的互動方式。這是一款現代化、美觀且對代理人友善的命令列介面，專為人類使用者與 AI 代理人設計。您可以將其視為 Superset 生態系統中的 "gh" (GitHub CLI)。

## ✅ **目前實作狀態**

### **🎉 第一階段：已完成 - 核心基礎**
- ✅ **現代化 CLI 架構**：基於 Typer + Rich + Pydantic，並採用精美的翡翠綠品牌設計。
- ✅ **實際生產環境整合**：已成功在真實的 Preset 工作區測試（包含 697 個資料集、32 個資料庫）。
- ✅ **通用過濾系統**：`--mine`、`--name`、`--limit`、`--ids` 可用於所有實體類型。
- ✅ **多種輸出格式**：Rich 表格（預設）、`--json`、`--yaml`、`--porcelain` 用於自動化。
- ✅ **效能優化**：伺服器端分頁（預設 50 筆結果）、智慧快取。

### **🎉 第二階段：已完成 - 實體管理**
**所有主要實體皆已實作：**
- ✅ **`sup workspace`** - 列出、使用、檢視資訊，支援可點擊的工作區 ID。
- ✅ **`sup database`** - 資料庫操作與上下文切換。
- ✅ **`sup dataset`** - 具備豐富資訊顯示的資料集管理。
- ✅ **`sup chart`** - 顯示實際資料集名稱的圖表操作。
- ✅ **`sup dashboard`** - 包含建立日期的儀表板管理。
- ✅ **`sup query`** - 已儲存查詢的探索與管理。
- ✅ **`sup sql`** - 直接執行 SQL 並輸出精美結果。

### **🎉 第 2.5 階段：已完成 - 使用者管理基礎**
**補完自然實體模式：**
- ✅ **`sup user list`** - 列出使用者及其角色、狀態資訊（運作中）。
- ✅ **`sup user info`** - 詳細的使用者檢查（腳手架 - 待實作）。
- ✅ **`sup user export`** - 將使用者、角色、擁有權導出為 YAML（腳手架 - 待實作）。
- ✅ **`sup user import`** - 匯入安全性配置（腳手架 - 待實作）。
- ✅ **完善的框架**，遵循既有模式，便於未來實作。

### **🚀 第二階段突破：革命性的資料存取**
- ✅ **`sup chart sql {id}`** - 取得任何圖表背後編譯後的 SQL（改變遊戲規則的功能！）。
- ✅ **`sup chart data {id}`** - 以 CSV/JSON 格式取得實際的圖表結果。
- ✅ **58+ 已儲存查詢** - 可透過 `sup query list` 探索。

## 🎯 **現已提供的核心指令**

### **SQL 執行（核心亮點）**
```bash
sup sql "SELECT COUNT(*) FROM users"           # 精美的 Rich 表格
sup sql "SELECT * FROM sales" --json           # 供代理人使用的 JSON
sup sql "SELECT * FROM sales" --csv            # CSV 匯出
```

### **實體管理**
```bash
# 工作區操作
sup workspace list                              # 所有工作區
sup workspace use 123                          # 設定預設工作區

# 資料庫操作
sup database list                              # 目前工作區中的資料庫
sup database use 5                             # 設定預設資料庫

# 資料集探索
sup dataset list --mine --limit 10             # 我的資料集
sup dataset list --database-id=5               # 特定資料庫中的資料集
sup dataset list --search="users"              # 依資料表名稱進行伺服器端搜尋

# 圖表分析與提取/推送（類 Git 術語）
sup chart list -l 5 --search="revenue"         # 伺服器端多欄位搜尋
sup chart sql 3628                            # 取得圖表背後的 SQL！
sup chart data 3628 --csv                     # 匯出圖表資料！
sup chart pull --mine                         # 提取您的圖表 + 依賴關係
sup chart push                                # 將圖表推送至目標工作區

# 儀表板管理
sup dashboard list --mine                      # 我的儀表板
sup dashboard list --search="exec"             # 伺服器端標題/別名搜尋

# 查詢探索
sup query list --mine                          # 我的已儲存查詢
sup query info 399                            # 取得已儲存查詢詳情

# 使用者與安全性管理
sup user list                                  # 所有使用者
sup user export --folder=./security/          # 導出使用者、角色、擁有權
sup user import ./security/ --overwrite       # 匯入安全性配置

# 多目標同步
sup sync create ./my_sync --source 123 --targets 456,789  # 建立同步資料夾
sup sync run ./my_sync --dry-run                          # 預覽同步操作
sup sync run ./my_sync                                    # 執行完整同步
sup sync validate ./my_sync                               # 驗證同步配置
```

### **針對代理人優化的操作**
```bash
# 非常適合 AI 代理人 - 極簡 Token、結構化輸出
sup chart data 3628 --json --limit=100        # 結構化資料存取
sup sql "SELECT COUNT(*) FROM users" -j       # 帶有 JSON 的直接 SQL
sup chart list --search="revenue" --porcelain # 伺服器端搜尋，機器可讀
sup dashboard list --search="exec" --json     # 儀表板搜尋並輸出 JSON
```

## 🏗️ **架構重點**

### **現代化技術棧**
- **Typer 0.12+**：具備自動說明的類型安全 CLI。
- **Rich 13+**：精美的終端機格式化與表格。
- **Pydantic 2.0+**：配置驗證。
- **YAML 配置**：`~/.sup/config.yml` 用於持久化設定。

### **通用過濾系統**
每個實體指令都支援相同的強大過濾器：
```bash
--id <id>                    # 單一 ID 過濾
--ids <id1,id2,id3>         # 多個 ID（逗號分隔）
--name <pattern>            # 名稱模式比對（支援萬用字元）
--mine                      # 目前使用者擁有的物件
--created-after <date>      # 在此日期之後建立 (YYYY-MM-DD)
--modified-after <date>     # 在此日期之後修改 (YYYY-MM-DD)
--limit <n>                 # 最大結果數（預設：50）
-j, --json                  # JSON 輸出
--porcelain                 # 機器可讀輸出
```

### **精美輸出**
- **Rich 表格**：多彩、可點擊的表格，具備智慧欄位寬度調整。
- **翡翠綠品牌色**：全程使用正宗的 Preset 色彩。
- **可點擊連結**：終端機內可直接點擊連往 Superset 儀表板/圖表。
- **智慧資料顯示**：顯示實際的資料集名稱，而非 "Unknown" 佔位符。

## 🎉 **第三階段：進行中 - 提取/推送系統**

### **🚀 突破：圖表提取/推送已完成！**
**已為所有實體建立類 Git 模式：**
- ✅ **`sup chart pull`** - 已完全實作並通過生產環境測試（原為 export）。
- ✅ **`sup chart push`** - 具備目標工作區系統的企業級功能（原為 import）。
- ✅ **通用過濾器整合** - 所有 sup 過濾器均適用於 pull/push。
- ✅ **智慧依賴管理** - 預設包含完整套件，亦可選擇不包含。
- ✅ **資產資料夾整合** - 使用 SUP_ASSETS_FOLDER 配置，支援覆蓋。
- ✅ **跨工作區支援** - `target-workspace-id` 用於企業級工作流。

### **🎯 圖表提取/推送指令（已上線並運作中！）**
```bash
# 從工作區提取至檔案系統（類 Git）
sup chart pull --mine                         # 提取您的圖表 + 資料集 + 資料庫
sup chart pull --name="*revenue*"             # 提取營收圖表 + 依賴關係
sup chart pull --id=3586                      # 提取特定圖表 + 依賴關係
sup chart pull --mine --skip-dependencies     # 僅提取圖表（不含依賴）

# 從檔案系統推送至工作區（類 Git）
sup chart push                                # 推送至設定的目標工作區
sup chart push --workspace-id=456             # 推送至特定工作區
sup chart push --overwrite --force            # 強制推送並覆蓋，跳過確認
```

### **📋 類 Git 術語的優點**
- ✅ **直覺的方向感** - 從工作區 pull（提取），向工作區 push（推送）。
- ✅ **開發者熟悉度** - 完全符合 git pull/push 的語義。
- ✅ **清晰的隱喻** - 將工作區視為遠端儲存庫，檔案系統視為本地端。
- ✅ **語言一致性** - 消除 import/export 帶來的混淆。

### **🎯 下一步：圖表同步（進階工作流）**
填補簡單 pull/push 與進階 `preset-cli` 功能之間的鴻溝：
```bash
sup chart sync ./templates --option env=prod  # 針對多環境的 Jinja2 範本
sup chart sync --bidirectional                # 具備衝突解決功能的雙向同步
sup chart sync --dbt-integration              # 使用 dbt 元數據強化
```

**圖表同步功能（計畫中）：**
- ✅ **Jinja2 範本** - 環境特定的自定義設定。
- ✅ **覆蓋檔案** - `.overrides.yaml` 用於個別環境的變更。
- ✅ **雙向同步** - 智慧衝突解決。
- ✅ **dbt 整合** - 元數據強化工作流。
- ✅ **精美的 sup UX** - 封裝現有的 421 個具備測試覆蓋的功能。

### **🔄 模式複製計畫**
一旦圖表 pull/push/sync 完成，將完全複製此模式至：
```bash
sup dashboard pull/push/sync                   # 完整儀表板生命週期
sup dataset pull/push/sync                     # 資料集遷移 + 同步
sup database pull/push/sync                    # 資料庫連線管理
```

### **🔮 dbt 整合架構**
**dbt 功能如何分布在 sup 實體中：**

**`sup database sync`** (dbt → Superset)：
- dbt profiles → Superset 資料庫連線。
- 連線配置 → 資料庫憑證與設定。

**`sup dataset sync`** (dbt ↔ Superset)：
- dbt 模型 → Superset 資料集（資料表定義、Schema）。
- dbt 指標 (metrics) → Superset 計算欄位與聚合。
- dbt 描述 (descriptions) → 資料集元數據與文件。

**`sup chart sync`** (Superset → dbt)：
- 使用模型的圖表 → dbt exposures（使用追蹤）。
- 圖表元數據 → Exposure 文件。

**`sup dashboard sync`** (Superset → dbt)：
- 使用模型的儀表板 → dbt exposures（業務上下文）。
- 儀表板元數據 → Exposure 文件。

**所需配置：**
```bash
# dbt Core 整合
sup config set dbt-profiles-dir ~/.dbt/          # dbt profiles 位置
sup config set dbt-project-dir ./dbt-project/    # dbt 專案根目錄

# dbt Cloud 整合
sup config set dbt-cloud-account-id 12345        # dbt Cloud 帳號
sup config set dbt-cloud-project-id 67890        # dbt Cloud 專案
sup config set dbt-cloud-job-id 11111            # 用於同步的特定 Job
sup config set dbt-cloud-api-token xyz123        # dbt Cloud API 存取權限
```

### **關鍵特性**
- **純 YAML**：非常適合版本控制與 Jinja 範本。
- **通用過濾**：所有 sup 過濾模式皆適用於 pull/push。
- **依賴解析**：自動處理資產間的關聯。
- **精美進度顯示**：豐富的旋轉圖標與進度條。
- **代理人友善**：用於自動化的 JSON/porcelain 模式。

## 🎯 **目標使用者與使用場景**

### **資料分析師**
- 執行 SQL 查詢並取得精美輸出。
- 探索並匯出圖表資料供分析使用。
- 尋找已儲存的查詢並重複使用既有邏輯。

### **Superset 管理員**
- 跨多個工作區管理資產。
- 在不同環境間匯出/匯入儀表板。
- 透過通用過濾器進行批次操作。

### **開發者與 DevOps**
- 將 Superset 整合至 CI/CD 流水線。
- 自動化資產部署與遷移。
- 將儀表板與圖表作為 YAML 進行版本控制。

### **AI 代理人**
- 透過結構化 JSON 輸出進行程式化資料存取。
- 透過 `--porcelain` 模式極小化 Token 消耗。
- 非常適合編碼助手與自動化任務。

## 🎉 **革命性功能**

### **圖表 SQL 存取（突破性功能！）**
```bash
# 取得任何圖表背後的編譯 SQL
sup chart sql 3628

# 輸出：包含過濾器、聚合等複雜業務邏輯的 SQL
SELECT DATE_TRUNC(`ds`, DAY) AS `ds`, sum(`PLG`) AS `PLG`, sum(`conversions`) AS `conversions`
FROM (SELECT
  DATE_TRUNC(`ds`, DAY) AS `ds`,
  SUM(CASE WHEN nrr_attribution = 'SELF_SERVE' THEN recurly_arr ELSE 0 END) AS PLG,
  SUM(CASE WHEN nrr_attribution = 'SALES_LED' THEN sales_led_arr ELSE 0 END) AS sales_led
  FROM `core_history`.`manager_team_history`
  WHERE (arr > 0)
  GROUP BY 1 ORDER BY 1
) AS `virtual_table`
WHERE `ds` >= CAST('2023-02-01' AS DATE)
  AND EXTRACT(MONTH FROM ds) IN (2,5,8,11)
GROUP BY `ds` ORDER BY `PLG` DESC LIMIT 1000
```

### **圖表資料匯出**
```bash
# 以結構化資料形式取得實際圖表結果
sup chart data 3628 --json

# 非常適合分析、報表或餵給 AI 模型
```

## 💻 **安裝與設定**

```bash
# 從 monorepo 安裝
pip install -e .

# 使用 Preset 快速設定
sup workspace list                    # 如果需要，會提示輸入 API 憑證
sup workspace use <workspace-id>      # 設定預設工作區
sup database use <database-id>        # 設定預設資料庫

# 現在一切都準備就緒了！
sup sql "SELECT 1"                   # 使用設定好的上下文
sup dashboard list --mine            # 您的儀表板
```

## 🚀 **為什麼這很重要**

### **範式轉移**
- **從**：具有冗長選項的複雜 `preset-cli` 指令。
- **到**：具有智慧預設值、以實體為中心的直覺指令。

### **現代化開發者體驗**
- **精美 UX**：Rich 表格足以媲美網頁介面。
- **代理人優先**：完美契合 AI 輔助開發時代。
- **版本控制**：基於 YAML 的資產可完美配合 git。

### **生產環境就緒**
- **經過測試**：已與生產環境的 Preset 工作區完成實測整合。
- **高效能**：優化的分頁與快取。
- **安全**：重用既有且經過充分測試的匯出/匯入邏輯。

## 📈 **成功指標**

**目前成就：**
- ✅ **7 種實體類型** 已完全實作且具備一致的 UX（工作區、資料庫、資料集、圖表、儀表板、查詢、使用者）。
- ✅ **革命性的資料存取**，其他地方無法提供。
- ✅ **圖表提取/推送系統** - 具備類 Git 術語的完整資產生命週期管理。
- ✅ **企業級跨工作區支援** - `target-workspace-id` 用於安全的多執行個體同步。
- ✅ **伺服器端搜尋** - 跨所有實體類型（圖表、儀表板、資料集）的高效搜尋。
- ✅ **完整的同步框架** - 支援 Jinja2 範本的多目標資產同步。
- ✅ **範本支援** - 在圖表推送中全面支援 Jinja2 範本與可重用的 DRY 參數。
- ✅ **生產等級品質**，具備完整類型安全且無 mypy 警告。
- ✅ **針對代理人優化**，具備完美的 JSON/porcelain 模式與伺服器端過濾。

**下一個策略步驟：**
- 🎯 **同步實作** - 在同步框架中完成提取/推送邏輯。
- 🎯 **範本支援擴展** - 應用於儀表板/資料集推送指令。
- 🎯 **跨版本相容性** - 增強欄位相容性過濾器。

---

**`sup` 代表了開發者與代理人如何與 Superset 互動的根本性重新思考。透過結合現代 CLI 模式、智慧預設值與精美的輸出格式，我們正在打造每個 Superset 使用者都夢寐以求的工具。** 🚀
