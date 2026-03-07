# sup CLI 文件

[![Built with Starlight](https://astro.badg.es/v2/built-with-starlight/tiny.svg)](https://starlight.astro.build)

這是 sup CLI 的文件網站 - 專為 Apache Superset 與 Preset 工作區打造的美觀、現代化介面。

## 🏗️ 架構

本文件網站採用混合方式構建：

- **自動生成**：從 sup CLI 透過 Typer 自省 (introspection) 生成指令參考頁面。
- **手動撰寫**：指南、教學與概念性文件。
- **主題**：使用帶有翡翠綠品牌色彩的 `starlight-theme-rapide`。

## 🚀 專案結構

```
docs-site/
├── src/
│   ├── content/
│   │   └── docs/
│   │       ├── commands/          # 自動生成的 CLI 指令文件
│   │       ├── config/            # 設定指南
│   │       ├── guides/            # 使用指南與教學
│   │       ├── index.mdx          # 首頁
│   │       ├── introduction.md    # 介紹
│   │       ├── installation.md    # 安裝指南
│   │       └── quick-start.md     # 快速上手指南
│   └── content.config.ts
├── astro.config.mjs               # Starlight + 主題設定
└── package.json
```

## 🧞 指令

所有指令皆在 `docs-site` 目錄下執行：

| 指令                      | 操作                                             |
| :------------------------ | :----------------------------------------------- |
| `npm install`             | 安裝相依套件                                     |
| `npm run dev`             | 在 `localhost:4321` 啟動本地開發伺服器           |
| `npm run build`           | 將生產環境網站建置於 `./dist/`                   |
| `npm run preview`         | 在部署前於本地預覽建置結果                       |

## 🔄 自動生成

指令文件是從 sup CLI 自動生成的：

```bash
# 從專案根目錄執行
python scripts/generate_cli_docs.py
```

這會從 Typer 提取指令資訊，並在 `src/content/docs/commands/` 中生成 MDX 檔案。

## 🎨 主題

使用 [starlight-theme-rapide](https://github.com/HiDeoo/starlight-theme-rapide)，並搭配翡翠綠強調色：

```js
starlightThemeRapide({
  starlightConfig: {
    accent: { 200: '#a7f3d0', 600: '#10b981', 900: '#047857', 950: '#022c22' }
  }
})
```

## 🚀 部署

當發生以下變動時，會透過 GitHub Actions 自動部署：
- CLI 原始碼變更 (`src/sup/**/*.py`)
- 文件變更 (`docs-site/**`)
- 文件生成器變更 (`scripts/generate_cli_docs.py`)

## 📝 參與貢獻

1. **CLI 指令**：自動生成 - 請修改原始碼與 Docstrings。
2. **指南**：編輯 `src/content/docs/guides/` 中的檔案。
3. **設定**：編輯 `src/content/docs/config/` 中的檔案。
4. **入門指南**：編輯 `introduction.md`、`installation.md`、`quick-start.md`。
