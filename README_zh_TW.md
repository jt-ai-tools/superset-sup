# 'sup! - 可能是最強大的非官方 Apache Superset CLI 🚀

<img width="453" height="162" alt="Image" src="https://github.com/user-attachments/assets/76433889-e9f9-4813-bfe3-9fd1e4bbe75f" />

**適用於 Apache Superset 與 Preset 工作區的現代化命令列介面**

*由 Preset 為您帶來，與 Preset 完全相容 • 專為進階使用者與 AI 代理人打造*

> **🧪 Beta 版本**：這是專為 Preset 客戶與 Superset 社群提供的實驗性 Beta 版本。
> 我們歡迎您的回饋與貢獻！請至 https://github.com/preset-io/superset-sup/issues 回報問題。

---

## ✨ 什麼是 'sup!?

'sup 是一款為 Apache Superset 進階使用者及其代理人設計的強大 CLI。它提供分類的說明文件、豐富的終端機格式化，以及類 Git 的工作流程，讓您能高效管理 Superset 與 Preset 工作區。

**[此處將展示精美的 ASCII 藝術與分類說明截圖]**

## 🎯 核心功能

- **執行任何 SQL**：透過 Superset 的資料存取層執行 SQL，並以豐富的表格、CSV、YAML 或 JSON 格式取得結果。
- **備份與還原**：備份與還原圖表、儀表板與資料集，並具備完整的依賴關係追蹤。
- **同步資產**：跨 Superset 執行個體同步資產，並支援 Jinja2 範本進行自定義。
- **強化元數據**：從 dbt Core/Cloud 匯入或導出元數據 - 未來將支援更多整合。
- **自動化工作流**：整合至 CI/CD 流水線。
- **完美的腳本支援**：適合用於自動化腳本與 AI 輔助的資料探索。

<img width="849" height="310" alt="Image" src="https://github.com/user-attachments/assets/994eba52-16cb-49aa-b370-deb7cf346c4c" />

## 🚀 快速上手

### 安裝

```bash
pip install superset-sup
```
或
```bash
pip install git+https://github.com/preset-io/superset-sup.git
```

### 開始使用

精美的分類說明將引導您完成完美的工作流程：

```bash
# 🔧 設定與安裝
sup config auth          # 設定身份驗證憑證
sup config show          # 驗證目前設定

# 🔍 直接存取資料
sup sql "SELECT COUNT(*) FROM users"           # 精美的 Rich 表格
sup sql "SELECT * FROM sales" --json           # 供代理人使用的 JSON
sup sql "SELECT * FROM sales" --csv            # CSV 匯出

# 📊 管理資產
sup workspace list       # 尋找您的工作區
sup workspace use 123    # 設定預設工作區
sup chart list --mine    # 搜尋您的圖表（支援伺服器端搜尋）
sup chart data 3628 --csv # 直接匯出圖表資料

# 🔄 跨工作區同步資產
sup sync create ./my_sync --source 123 --targets 456,789  # 支援 Git 的同步設定
sup sync run ./my_sync --dry-run                          # 預覽操作
sup sync run ./my_sync                                    # 執行同步
```

## 📋 指令參考

### 設定與安裝
- `sup config` - 包含來源、設定與安裝步驟的精美設定指南
- `sup config auth` - 設定身份驗證憑證
- `sup config show` - 顯示目前設定
- `sup config set workspace-id 123` - 設定預設工作區

### 直接存取資料
- `sup sql "query"` - 執行 SQL 並輸出精美結果
- `sup sql --interactive` - 互動式 SQL 工作階段（即將推出）
- `sup sql "query" --json` - 用於自動化的 JSON 輸出
- `sup sql "query" --porcelain` - 機器可讀的原始輸出

### 管理資產
- `sup workspace list` - 列出可用的工作區
- `sup database list` - 資料庫操作
- `sup dataset list --search="users"` - 依資料表名稱進行伺服器端搜尋
- `sup chart list --mine --search="revenue"` - 多欄位圖表搜尋
- `sup chart sql 3628` - 取得任何圖表背後編譯後的 SQL
- `sup chart data 3628 --csv` - 匯出實際的圖表資料
- `sup dashboard list --search="exec"` - 儀表板標題/別名（slug）搜尋
- `sup query list --mine` - 探索已儲存的查詢
- `sup user list` - 使用者管理

### 跨工作區同步資產
- `sup sync create` - 使用範本建立同步設定
- `sup sync run --dry-run` - 預覽同步操作
- `sup sync validate` - 驗證同步設定
- 支援 Jinja2 範本的企業級跨工作區工作流

## 🎨 精美特性

### 分類說明系統
指令依邏輯區塊組織，引導您的工作流程：
- **設定與安裝** → **直接存取資料** → **管理資產** → **同步**

### 豐富的輸出格式
- **Rich 表格**：多彩、可點擊的表格，採用翡翠綠的 Preset 品牌色
- **JSON**：非常適合 AI 代理人與自動化 (`--json`)
- **CSV**：直接資料匯出 (`--csv`)
- **YAML**：便於配置的格式 (`--yaml`)
- **Porcelain**：機器可讀，無任何裝飾 (`--porcelain`)

### 過濾功能
每個實體指令都支援強大且一致的過濾器：
```bash
--mine                      # 目前使用者擁有的物件
--name "pattern*"           # 使用萬用字元的名稱模式比對
--limit 50                  # 結果分頁（預設：50）
--search "revenue"          # 伺服器端搜尋（圖表、儀表板、資料集）
--json                      # 用於自動化的 JSON 輸出
```

### 針對代理人優化
完美適配 AI 助手與自動化：
```bash
sup chart data 3628 --json --limit=100        # 結構化資料存取
sup sql "SELECT COUNT(*) FROM users" --json   # 帶有 JSON 的直接 SQL
sup dashboard list --search="exec" --porcelain # 機器可讀輸出
```

## 🔄 類 Git 的資產工作流

### 圖表生命週期（生產環境就緒）
```bash
# 將圖表及其依賴關係提取到檔案系統
sup chart pull --mine                         # 提取您的圖表 + 資料集 + 資料庫
sup chart pull --name="*revenue*"             # 提取營收相關圖表 + 依賴關係
sup chart pull --id=3586                      # 提取特定圖表 + 依賴關係

# 從檔案系統推送至工作區
sup chart push                                # 推送至設定的目標工作區
sup chart push --workspace-id=456             # 推送至特定工作區
sup chart push --overwrite --force            # 強制推送並覆蓋，跳過確認
```

### 進階同步工作流
```bash
# 使用範本進行多目標同步
sup sync create ./templates --source 123 --targets 456,789,101
sup sync run ./templates --option env=prod    # 為不同環境使用 Jinja2 範本
sup sync run --bidirectional                 # 具備衝突解決功能的雙向同步
```

## 🏗️ 架構

### 現代化技術棧
- **Typer 0.12+**：具備自動說明生成的類型安全 CLI
- **Rich 13+**：精美的終端機格式化與表格
- **Pydantic 2.0+**：配置驗證與類型安全
- **Pandas**：資料處理與多種輸出格式

### 配置管理
- **全域**：`~/.sup/config.yml` 用於使用者偏好設定
- **專案**：`.sup/state.yml` 用於專案特定設定
- **環境變數**：`SUP_*` 變數具有最高優先權
- **優先順序**：環境變數 → 全域 → 專案

### 企業級功能
- **跨工作區同步**：來源工作區 → 多個目標工作區
- **資產依賴**：自動解析 圖表 → 資料集 → 資料庫 的依賴關係
- **Jinja2 範本**：環境特定的自定義設定
- **Git 就緒**：基於 YAML 的資產可完美配合版本控制

## 🎯 額外功能

### 圖表 SQL 存取
取得任何圖表背後的編譯 SQL - 包含業務邏輯：
```bash
sup chart sql 3628
# 輸出：包含過濾器、聚合、Join 的複雜 SQL - 實際在 Superset 運行的查詢
```

### 圖表資料匯出
以結構化資料形式存取實際圖表結果：
```bash
sup chart data 3628 --json     # 非常適合分析、報表、AI 模型
sup chart data 3628 --csv      # 直接 CSV 匯出
```

### 伺服器端搜尋
跨所有實體類型的高效搜尋：
- **圖表**：`--search` 使用多欄位搜尋（標題、描述等）
- **儀表板**：`--search` 搜尋標題與別名（slug）
- **資料集**：`--search` 搜尋資料表名稱
- 所有搜尋均支援 `--limit` 以確保效能

## 🏠 Superset 相容性

### 主要焦點：Preset 託管執行個體
'sup 主要針對 **Preset 託管的 Superset 執行個體** 設計，並已在 Preset 工作區進行廣泛測試。所有功能均可在 Preset 的多工作區環境中無縫運作。

### 自行託管的 Superset
**它能在我的 Superset 執行個體上運作嗎？** 大多數功能應該可以運作，但視您的身份驗證設定而定，您可能需要調整程式碼。我們歡迎來自廣大 Superset 社群的貢獻以提升相容性。

**無 Preset 模式**：未來的版本可能會為單一執行個體的 Superset 部署移除多工作區結構。如果您對此感興趣，請參與貢獻或開啟 Issue。

### 為了更廣泛相容性的貢獻
我們歡迎任何能讓 'sup 適用於整個 Superset 社群的貢獻。對於自行託管執行個體，可能需要改進的部分包括：
- 除了 Preset API Token 之外的身份驗證方法
- 單一執行個體模式（移除工作區概念）
- 不同的 API 端點結構

## 🔐 身份驗證

支援多種身份驗證方法：

### API Token (推薦)
```bash
sup config auth  # 互動式設定
# 或設定環境變數：
export SUP_PRESET_API_TOKEN="your-token"
export SUP_PRESET_API_SECRET="your-secret"
```

### 環境變數
```bash
SUP_WORKSPACE_ID=123        # 預設工作區
SUP_DATABASE_ID=5           # 預設資料庫
SUP_TARGET_WORKSPACE_ID=456 # 跨工作區同步目標
SUP_ASSETS_FOLDER=./assets  # 資產儲存位置
```

## 🎨 開發者專區

### AI 代理人整合
'sup 的設計對 AI 極其友善：
- **一致的模式**：所有指令遵循相同的過濾器模式
- **結構化輸出**：用於自動化的 JSON 與 porcelain 模式
- **伺服器端過濾**：高效的資料存取
- **極簡 Token 消耗**：為 AI 上下文視窗優化

### CI/CD 整合
```bash
# 在您的 CI 流水線中：
sup chart pull --mine --skip-dependencies     # 僅提取圖表
sup chart push --workspace-id=$PROD_WS --force # 部署至生產環境
sup sync run ./deploy --option env=production  # 多環境部署
```

## 🆚 舊版 CLI (preset-cli & superset-cli)

此套件包含三個命令列工具：
- **`sup`** - 推薦使用的現代化 CLI，具備精美的 UX（🆕 開發重點）
- **`preset-cli`** - 專為 Preset 工作區設計的舊版 CLI（維護模式）
- **`superset-cli`** - 專為獨立 Superset 設計的舊版 CLI（維護模式）

這三個 CLI 會同時安裝，確保與現有工作流的向下相容性，同時提供遷移至現代化 `sup` 體驗的平滑路徑。

### 為什麼選擇 'sup?
'sup 在保持完全相容性的同時，取代並現代化了舊版工具：

- **精美 UX**：豐富的格式化 vs 純文字
- **邏輯組織**：分類說明 vs 冗長的指令列表
- **類 Git 工作流**：直覺的提取/推送 vs 複雜的匯出/匯入
- **針對代理人優化**：AI 助手的完美搭檔
- **類型安全**：具備完整類型提示的現代化 Python

### 舊版 CLI 文件

對於仍在使用 `preset-cli` 或 `superset-cli` 的使用者，請參考 [原始 preset-cli 儲存庫](https://github.com/preset-io/preset-cli) 取得完整文件。我們建議遷移至 `sup` 以獲得最佳體驗，但舊版 CLI 仍將繼續運作。

**遷移路徑**：大多數指令在 `sup` 中都有直接對應的指令。例如：
```bash
# 舊版 preset-cli
preset-cli --workspaces=https://workspace.preset.io/ superset export

# 現代化 sup
sup workspace use 123
sup chart pull --mine
```
