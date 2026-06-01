#!/usr/bin/env bash
# SYNKA 公式サイト — ローカルプレビュー
#   ./preview.sh           ライブプレビュー（http://127.0.0.1:8000、編集が即反映、Ctrl+C で停止）
#   ./preview.sh build     ./site/ に静的生成して確認（site/ は .gitignore 済でコミットされない）
#
# 生成物（.venv / site/）はいずれも .gitignore 済み。リポジトリにはコミットされない。
set -euo pipefail
cd "$(dirname "$0")"

# 初回のみ: ローカル venv を作成し依存（mkdocs-material 等）をインストール（.venv は gitignore 済）
if [ ! -x .venv/bin/mkdocs ]; then
  echo "▶ 初回セットアップ: .venv を作成し依存をインストールします..."
  if command -v uv >/dev/null 2>&1; then
    uv venv .venv
    uv pip install --python .venv/bin/python -r requirements.txt
  else
    python3 -m venv .venv
    ./.venv/bin/python -m pip install --quiet --upgrade pip
    ./.venv/bin/python -m pip install --quiet -r requirements.txt
  fi
fi

case "${1:-serve}" in
  build)
    echo "▶ 静的生成 → ./site/（.gitignore 済・非コミット）"
    ./.venv/bin/mkdocs build --strict
    echo "✅ 完了: $(pwd)/site/index.html をブラウザで開いて確認できます"
    ;;
  *)
    echo "▶ ライブプレビュー: http://127.0.0.1:8000  （Ctrl+C で停止）"
    exec ./.venv/bin/mkdocs serve
    ;;
esac
