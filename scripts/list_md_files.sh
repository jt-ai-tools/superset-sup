#!/bin/bash
find . -type f \( -name "*.md" -o -name "*.mdx" \) \
  -not -path "*/.*" \
  -not -name "PROGRESS.md" \
  -not -name "*_zh_TW.md" \
  -not -name "*_zh_TW.mdx"
