#!/bin/bash

# 1. 檢查是否所有 md/mdx 都有對應的 _zh_TW 版本
./scripts/list_md_files.sh | while read -r file; do
    ext="${file##*.}"
    base="${file%.*}"
    zh_file="${base}_zh_TW.${ext}"
    if [ ! -f "$zh_file" ]; then
        echo "Missing translation: $zh_file"
    fi
done

# 2. 檢查 _zh_TW 檔案中的連結是否也指向 _zh_TW
find . -type f \( -name "*_zh_TW.md" -o -name "*_zh_TW.mdx" \) | while read -r zh_file; do
    # 簡單檢查是否存在 [text](path.md) 形式的連結，且 path.md 沒有 _zh_TW
    # 這只是一個基本的 grep 檢查
    if grep -E "\[.*\]\([^)]+\.mdx?\)" "$zh_file" | grep -v "_zh_TW\." | grep -v "http" > /dev/null; then
        echo "Check links in: $zh_file (may contain links to non-zh_TW files)"
    fi
done
