# SYNKA 公式サイト（synka-website）

東京大学 情報基盤センター・東京大学生産技術研究所が運用する GPU クラスタ **SYNKA** の公式サイトのソースです。
[MkDocs](https://www.mkdocs.org/) ＋ [Material for MkDocs](https://squidfunk.github.io/mkdocs-material/) で構築し、GitHub Actions で自動ビルドして GitHub Pages に公開します。

- 公開 URL: https://www.synka-jp.org/ （カスタムドメイン設定後）
- 既定 URL: https://toyolabo.github.io/synka-website/

## ディレクトリ構成

```
synka-website/
├── docs-onepager/                # サイトコンテンツ（mkdocs の docs_dir）
│   ├── index.md                  # ページ本体（1 ページ完結のペライチ構成）
│   ├── onepager-assets/
│   │   └── images/               # 画像（システム構成図など）
│   └── stylesheets/
│       └── extra.css             # 追加スタイル
├── mkdocs.yml                    # MkDocs 設定（テーマ・プラグイン等）
├── requirements.txt              # Python 依存（mkdocs / mkdocs-material / mkdocs-macros-plugin）
├── preview.sh                    # ローカルプレビュー用スクリプト
├── .github/workflows/deploy.yml  # GitHub Actions（push 時に build → gh-pages へデプロイ）
└── README.md
```

> ビルド成果物 `site/` とローカル仮想環境 `.venv/` は生成物のため Git 管理対象外です（`.gitignore` 済）。

## ローカルプレビュー

`preview.sh` が初回に仮想環境（`.venv/`）を作成し、依存をインストールします（`uv` があれば利用、無ければ `python3 -m venv` にフォールバック）。

```bash
# ライブプレビュー（編集が即反映。http://127.0.0.1:8000 で表示 / Ctrl+C で停止）
./preview.sh

# 静的ビルドのみ（出力: ./site/。ブラウザで site/index.html を開いて確認）
./preview.sh build
```

必要環境: Python 3.x（Material for MkDocs 9 系）。

## 編集方法

- ページ本文は `docs-onepager/index.md` を編集します（ペライチ構成）。
- 画像は `docs-onepager/onepager-assets/images/` に配置します。
- 規程・利用ガイド・料金表・申請フォーム等の配布物はリポジトリに同梱せず、Google Drive 上のファイルへリンクします。

## デプロイ

`main` ブランチへ push すると GitHub Actions（`.github/workflows/deploy.yml`）が `mkdocs build --strict` を実行し、成果物を `gh-pages` ブランチへデプロイします。

公開設定は **Settings → Pages → Build and deployment** で `Deploy from a branch` ／ ブランチ `gh-pages` ／ `/ (root)` を選択します。カスタムドメインを利用する場合は同画面の **Custom domain** に `www.synka-jp.org` を設定し、DNS 側で `www` の CNAME を `toyolabo.github.io` に向けたうえで **Enforce HTTPS** を有効化します。
