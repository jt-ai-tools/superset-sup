# 發佈至 PyPI

本文件說明如何將 `superset-sup` 發佈至 PyPI。

## 套件資訊

- **套件名稱**：`superset-sup`
- **安裝指令**：`sup`, `preset-cli`, `superset-cli`
- **授權協議**：Business Source License 1.1
- **狀態**：Beta/實驗性版本

## 準備工作

1. **PyPI 帳號**：您需要一個對 `superset-sup` 套件具備維護者 (maintainer) 權限的 PyPI 帳號。
2. **API Token**：在 https://pypi.org/manage/account/token/ 生成 PyPI API Token。
3. **GitHub Secrets**：若要進行自動化發佈，請確保已在儲存庫的 Secrets 中設定 `PYPI_API_TOKEN`。

## 發佈方法

### 方法 1：透過 GitHub Actions 自動發佈（推薦）

本儲存庫包含一個 GitHub Actions 工作流 (`.github/workflows/python-publish.yml`)，當建立新的 Release 時，該工作流會自動發佈至 PyPI。

**步驟：**

1. 確保所有變更已提交 (commit) 並推送 (push) 至 `main` 分支。
2. 為該版本建立新的 Git 標籤 (tag)：
   ```bash
   git tag v0.1.0
   git push origin v0.1.0
   ```
3. 在 https://github.com/preset-io/superset-sup/releases/new 根據該標籤建立 GitHub Release。
4. GitHub Action 將自動建置並發佈至 PyPI。

### 方法 2：手動發佈

若您需要手動發佈：

1. **安裝建置工具：**
   ```bash
   pip install build twine
   ```

2. **清理先前的建置檔案：**
   ```bash
   rm -rf dist/ build/ src/*.egg-info
   ```

3. **建置發佈套件：**
   ```bash
   python -m build
   ```

4. **檢查建置好的套件：**
   ```bash
   ls -lh dist/
   # 應顯示 .tar.gz 與 .whl 檔案
   ```

5. **驗證套件（可選，但建議執行）：**
   ```bash
   twine check dist/*
   ```

6. **上傳至 PyPI：**
   ```bash
   # 上傳至正式環境 PyPI
   twine upload dist/*

   # 上傳至 TestPyPI（建議初次測試時使用）
   twine upload --repository testpypi dist/*
   ```

## 版本管理

本專案使用 `setuptools_scm` 根據 Git 標籤自動進行版本管理：

- 開發版本：`0.0.post1.dev638+geaa24fa4d.d20251106`（自動生成）
- 發佈版本：`0.1.0`（根據 Git 標籤）

若要建立發佈版本，只需建立並推送 Git 標籤：

```bash
git tag v0.1.0
git push origin v0.1.0
```

## 測試安裝

發佈後，請測試安裝是否成功：

```bash
# 從 PyPI 安裝
pip install superset-sup

# 驗證三個指令是否皆可用
sup --help
preset-cli --help
superset-cli --help
```

## 發佈前檢查清單

在發佈新版本之前：

- [ ] 更新 `CHANGELOG.rst` 中的版本資訊。
- [ ] 確保所有測試皆通過：`make test`。
- [ ] 驗證建置是否成功：`python -m build`。
- [ ] 檢視 `README.md` 的正確性。
- [ ] 確保 `LICENSE.txt` 為最新版本。
- [ ] 在乾淨的虛擬環境中測試安裝。
- [ ] 在 Git 中標記該版本：`git tag v0.X.Y`。

## 先發佈至 TestPyPI 測試

對於 Beta 版本，建議先發佈至 TestPyPI：

1. **上傳至 TestPyPI：**
   ```bash
   twine upload --repository testpypi dist/*
   ```

2. **從 TestPyPI 測試安裝：**
   ```bash
   pip install --index-url https://test.pypi.org/simple/ --extra-index-url https://pypi.org/simple/ superset-sup
   ```

3. **若一切正常，再發佈至正式環境 PyPI：**
   ```bash
   twine upload dist/*
   ```

## 常見問題排除

### 建置警告

您可能會看到關於授權配置的棄用警告，這些資訊不影響發佈：
- `project.license as a TOML table is deprecated`
- 這些問題將在未來的 `setuptools` 更新中解決。

### 版本衝突

若從 PyPI 收到「檔案已存在 (File already exists)」錯誤：
- 您無法重複上傳相同版本號的檔案。
- 請建立一個遞增版本號的新 Git 標籤。
- 清理並重新建置：`rm -rf dist/ && python -m build`。

## 支援服務

若有任何問題或疑慮：
- GitHub Issues: https://github.com/preset-io/superset-sup/issues
- 舊版 CLI 文件: https://github.com/preset-io/preset-cli
