# 人狼BOYZ Rails

人狼BOYZ の Rails API アプリケーションです。

## セットアップ

セットアップ手順は [SETUP.md](./SETUP.md) を参照してください。

※ `rails new . --force` 実行により README.md が上書きされる場合があります。そのためセットアップ手順は SETUP.md に記載しています。

## プロジェクト概要

- **Ruby**: プロジェクトの Ruby バージョンを確認してください（`.ruby-version` 等）
- **システム依存**: Docker, Docker Compose, MySQL, Redis
- **構成**: Rails API モード（`--api`）
- **認証**: Devise + JWT

## データベース

- MySQL（開発/テスト/本番）
- Redis（セッション・キャッシュ等）

## テスト

RSpec を使用しています。実行方法は [SETUP.md](./SETUP.md) の「8. テスト実行」を参照してください。

## デプロイ

デプロイ手順は別途ドキュメントを参照してください。
