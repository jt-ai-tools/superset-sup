# CLAUDE.md

本檔案為 Claude Code (claude.ai/code) 在此儲存庫中進行開發時提供導引。

## 專案概觀

這是 `preset-cli`，一個用於與 Preset (https://preset.io/) 工作區互動的命令列介面。此 CLI 允許使用者：

- 針對工作區中的分析型資料庫執行 SQL 查詢。
- 使用類 Git 的工作流提取 (pull)/推送 (push) 資源（資料庫、資料集、圖表、儀表板）。
- 將 dbt Core/Cloud 專案同步至 Preset 工作區。
- 管理使用者、團隊與工作區權限。
- 透過 API Token 或 JWT 進行身份驗證。

本專案提供三個主要的 CLI 入口點：
- `preset-cli`：用於與 Preset 工作區互動的舊版 CLI。
- `superset-cli`：用於獨立 Superset 執行個體的舊版 CLI。
- `sup`：具備精美 UX 的現代化類 Git CLI（**新功能 - 目前開發重點**）。

## 架構與程式碼結構

### 舊版 CLI 結構
```
src/preset_cli/
├── api/clients/          # API 用戶端實作
│   ├── preset.py        # Preset API 用戶端
│   └── superset.py      # Superset API 用戶端
├── auth/                # 身份驗證模組
│   ├── preset.py        # Preset 特定驗證
│   ├── superset.py      # Superset 驗證
│   ├── jwt.py           # JWT Token 處理
│   └── token.py         # Token 管理
├── cli/                 # CLI 指令實作
│   ├── main.py          # preset-cli 主要入口點
│   ├── superset/        # Superset 特定指令
│   │   ├── main.py      # superset-cli 入口點
│   │   ├── export.py    # 導出資源
│   │   ├── sql.py       # SQL 執行
│   │   └── sync/        # 同步指令
│   │       ├── native/  # 原生 YAML 同步
│   │       └── dbt/     # dbt 專案同步
│   └── export_users.py  # 使用者導出功能
└── lib.py              # 共用工具程式
```

### 現代化 sup CLI 結構（新）
```
src/sup/
├── main.py                    # 具備精美品牌設計的 sup 主要入口點
├── commands/                  # 以實體為中心的指令模組
│   ├── workspace.py          # 工作區管理 + 跨工作區配置
│   ├── database.py           # 資料庫操作
│   ├── dataset.py            # 資料集管理
│   ├── chart.py              # 圖表提取/推送與依賴管理
│   ├── dashboard.py          # 儀表板操作
│   ├── query.py              # 已儲存查詢探索
│   ├── user.py               # 使用者管理
│   ├── sql.py                # 直接執行 SQL
│   ├── sync.py               # 多資產同步操作（新）
│   └── config.py             # 配置管理
├── clients/                   # sup 特定的用戶端封裝
│   ├── preset.py             # 封裝後的 PresetClient，具備 sup UX
│   └── superset.py          # 封裝後的 SupersetClient，具備 sup UX
├── config/                    # 現代化 Pydantic 配置
│   ├── settings.py           # 類型安全的配置模型
│   ├── sync.py               # 同步配置模型（新）
│   └── paths.py              # 配置文件路徑解析
├── filters/                   # 通用過濾系統
│   ├── base.py               # 適用於所有實體的 UniversalFilters
│   └── chart.py              # 圖表特定過濾器
├── output/                    # 精美的 Rich 輸出系統
│   ├── styles.py             # 翡翠綠 Preset 品牌風格
│   ├── formatters.py         # 輸出格式處理程式
│   ├── tables.py             # Rich 表格格式化
│   └── spinners.py           # 載入指示器
└── auth/                      # 身份驗證封裝
    └── preset.py             # 與 sup 相容的驗證
```

### 舊版 CLI 組件

- **API 用戶端**：`PresetClient` 與 `SupersetClient` 處理 REST API 互動。
- **身份驗證**：支援 JWT Token、API Token/Secret 對，以及憑證儲存。
- **CLI 指令**：使用 Click 框架構建，具備階層式指令結構。
- **範本化**：使用 Jinja2 處理參數化的 YAML 配置文件。
- **同步操作**：檔案系統與工作區之間的雙向同步。

### 現代化 sup CLI 組件（新）

- **實體指令**：圖表 (chart)、儀表板 (dashboard)、資料集 (dataset)、資料庫 (database)、使用者 (user)、工作區 (workspace)、查詢 (query)。
- **通用過濾**：所有實體均支援一致的 `--mine`、`--name`、`--ids`、`--limit` 模式。
- **提取/推送操作**：類 Git 的資產生命週期管理，包含依賴關係處理。
- **跨工作區支援**：企業級 `target-workspace-id` 用於多執行個體同步。
- **精美 UX**：Rich 表格、翡翠綠品牌設計、旋轉圖標、進度回饋。
- **配置**：具備 YAML 持久化的類型安全 Pydantic 模型。
- **輸出格式**：Rich 表格、JSON、YAML、CSV、porcelain 用於自動化。

## sup CLI 開發（目前重點）

### sup 指令（生產環境就緒）
```bash
# 核心工作流
sup workspace list                            # 精美的 Rich 表格
sup workspace use 123                         # 設定來源工作區
sup workspace set-target 456                  # 設定跨工作區同步的推送目標
sup workspace show                            # 顯示來源與目標上下文

# 支援多種格式的 SQL 執行
sup sql "SELECT * FROM users LIMIT 5"        # Rich 表格輸出
sup sql "SELECT COUNT(*) FROM sales" --json  # 用於自動化的 JSON

# 圖表生命週期管理（完整模式 - 生產環境）
sup chart list --mine --limit 10              # 通用過濾
sup chart pull --mine                         # 將圖表 + 依賴關係提取至 ./assets/
sup chart push --workspace-id=456 --force     # 推送至目標工作區

# 儀表板生命週期管理（存根 - 遵循圖表模式）
sup dashboard list --mine                     # 通用過濾
sup dashboard pull --mine                     # 提取儀表板 + 依賴關係（尚未實作）
sup dashboard push                            # 將儀表板推送至工作區（尚未實作）

# 資料集生命週期管理（存根 - 遵循圖表模式）
sup dataset list --search="sales"             # 通用過濾
sup dataset pull --mine                       # 提取資料集 + 依賴關係（尚未實作）
sup dataset push                              # 將資料集推送至工作區（尚未實作）

# 使用者管理（唯讀）
sup user list --limit 50                      # 列出工作區中的使用者
# 注意：刻意不實作使用者 pull/push（安全/RBAC 考量）

# 多資產同步工作流（新 - 運作中）
sup sync create ./my_sync --source 123 --targets 456,789  # 建立同步配置
sup sync run ./my_sync --dry-run                          # 預覽操作
sup sync run ./my_sync --pull-only                        # 從來源提取
sup sync validate ./my_sync                               # 驗證配置

# 配置管理
sup config show                               # 顯示目前所有設定
sup config set target-workspace-id 789        # 設定跨工作區目標
```

### sup 開發狀態 - 提取/推送術語

**術語標準**：所有 `sup` 指令均使用 **pull/push**（而非 import/export）以維持類 Git UX 的一致性。

**實體 Pull/Push 狀態**：
- ✅ **chart**：具備依賴管理的完整 pull/push 實作（生產環境）。
- 🔨 **dashboard**：已加入 pull 指令存根，push 尚未實作。
- 🔨 **dataset**：已加入 pull 指令存根，push 尚未實作。
- 🔨 **database**：無 pull/push 指令（透過配置文件管理）。
- ❌ **user**：刻意不提供 pull/push（安全/RBAC 考量，僅供列表顯示）。
- ❌ **query**：無 pull/push（僅供探索的實體）。

**額外特性**：
- ✅ **企業級功能**：跨工作區同步、目標配置、安全性確認。
- ✅ **生產環境測試**：與真實 Preset 工作區的實測整合。
- ✅ **多資產同步框架**：基於 YAML 的同步配置，具備自動依賴解析。
- ✅ **同步提取 (Pull) 實作**：使用舊版 `export_resource` 的完整功能實作。
- 🎯 **下一步**：儀表板/資料集 pull 實作、多目標工作流的同步推送 (push)。

## 多資產同步實作（新）

### 同步架構決策

**同步實作過程中的關鍵架構選擇：**

1. **同步時始終覆蓋**：從同步配置 Schema 中移除了 `overwrite` 選項。
   - 同步操作具有強制性：本地應與遠端一致。
   - 使用者可透過 Git 確保安全性 (`git stash`, `git diff`, `--dry-run`)。
   - 消除同步配置的複雜性與使用者困惑。

2. **多資產類型支援**：單一同步配置可處理多種資產類型。
   - 每次 `export_zip()` 調用都會自動包含依賴關係。
   - 後續的資產導出會覆蓋先前的依賴檔案（這是有益的）。
   - 在同步操作期間取得最新的依賴狀態。

3. **透過舊版 CLI 進行原子操作**：
   - 來自 `preset_cli.cli.superset.export` 的 `export_resource()` 提供原子級導出。
   - `client.export_zip(resource_name, ids)` 處理批次與依賴關係。
   - 重用經過實戰測試且具備正確錯誤處理的導出邏輯。

### 同步配置 Schema

```yaml
# sync_config.yml - 多目標同步配置
source:
  workspace_id: 187
  assets:
    dashboards:
      selection: ids
      ids: [254]
      include_dependencies: true
    charts:
      selection: all
      include_dependencies: true
    # 注意：無 overwrite 選項 - 同步操作中始終為 true

target_defaults:
  overwrite: false                    # 用於推送操作
  jinja_context:
    company: Default Company
    region: us-east-1

targets:
  - workspace_id: 456
    name: production
    jinja_context:
      environment: production
```

### 同步實作狀態

- ✅ **同步配置模型**：具備驗證功能的 Pydantic 模型。
- ✅ **同步提取 (Pull)**：使用 `export_resource()` 的有效實作。
- ✅ **多資產支援**：單一配置可處理資料庫、資料集、圖表、儀表板。
- ✅ **依賴解析**：透過現有的 `export_zip` 邏輯自動處理。
- ✅ **試執行 (Dry Run)**：不執行實際操作即可預覽。
- 🎯 **同步推送 (Push)**：連接至現有的 `native()` 匯入功能。
- 🎯 **Jinja 範本化**：環境特定的資產自定義。

### dbt 整合實體分布
**dbt 功能如何對應至 sup 實體：**

- **`sup database pull`**：dbt profiles → Superset 資料庫連線。
- **`sup dataset pull`**：dbt 模型 → Superset 資料集（Schema、指標、元數據）。
- **`sup chart pull`**：Superset 圖表 → dbt exposures（使用追蹤）。
- **`sup dashboard pull`**：Superset 儀表板 → dbt exposures（業務上下文）。

**dbt 整合所需的 sup 配置鍵值：**
```bash
# dbt Core
dbt-profiles-dir, dbt-project-dir

# dbt Cloud
dbt-cloud-account-id, dbt-cloud-project-id, dbt-cloud-job-id, dbt-cloud-api-token
```

## 舊版 CLI 開發指令

### 環境設定
```bash
# 首先啟動虛擬環境
source .venv/bin/activate

# 使用 uv（推薦，安裝速度最快）
uv pip install -e '.[testing]'

# 或使用 make（內部使用 uv）
make install
```

### 測試
```bash
# 執行所有測試並產出覆蓋率報告
make test

# 直接執行 pytest 並產出覆蓋率報告
pytest --cov=src/preset_cli -vv tests/ --doctest-modules src/preset_cli
```

### 程式碼品質
```bash
# 執行 pre-commit 勾子（linting、格式化等）
make check

# 拼字檢查文件與程式碼
make spellcheck
```

### 依賴管理
```bash
# 從 requirements.in 更新 requirements.txt
make requirements.txt

# 從 dev-requirements.in 更新 dev-requirements.txt
make dev-requirements.txt
```

### 清理
```bash
# 移除虛擬環境
make clean
```

## CLI 使用模式

CLI 使用共同模式：
1. 身份驗證（API Token、JWT 或互動式提示）。
2. 工作區/團隊選擇（互動式或透過 `--workspaces`/`--teams` 標籤）。
3. 執行指令並帶入資源特定選項。

指令結構範例：
```bash
preset-cli --workspaces=https://workspace.preset.io/ superset [指令] [選項]
```

## 關鍵配置文件

- **setup.cfg**：主要套件配置、依賴關係與 pytest 設定。
- **Makefile**：開發工作流自動化。
- **pyproject.toml**：構建系統配置。
- **.pre-commit-config.yaml**：程式碼品質勾子。
- **tox.ini**：測試環境配置。

## 身份驗證流程

1. 檢查環境變數中的 JWT Token (`PRESET_JWT_TOKEN`)。
2. 檢查環境變數中的 API 憑證 (`PRESET_API_TOKEN`, `PRESET_API_SECRET`)。
3. 在系統相關位置尋找儲存的憑證。
4. 以互動方式提示使用者，並可選擇儲存憑證。

## 測試框架

- 使用 pytest 並產出覆蓋率報告。
- 在原始碼模組中包含 doctest。
- 使用 Mock 物件進行 API 互動。
- 測試覆蓋率目標配置於 `setup.cfg` 中。

## 依賴關係

關鍵依賴包括：
- Click：用於 CLI 框架。
- PyYAML：用於配置解析。
- Jinja2：用於範本化。
- SQLAlchemy：用於資料庫操作。
- Requests：用於 HTTP 用戶端。
- Rich：用於終端機格式化。
