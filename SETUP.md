# 人狼BOYZ Rails セットアップ手順

## 0. イメージのビルド（Gemfile 変更後）

```bash
docker compose build api
```

## 1. Rails アプリケーションの生成（初回のみ）

```bash
docker compose run --no-deps api rails new . --api -d mysql \
  --skip-docker \
  --skip-action-mailbox \
  --skip-action-text \
  --skip-asset-pipeline \
  --skip-javascript \
  --skip-hotwire \
  --skip-test \
  --skip-system-test \
  --skip-kamal \
  --skip-solid \
  --skip-devcontainer \
  --skip-edge \
  --force --skip-bundle
```

## 2. 依存関係のインストール

```bash
# イメージをビルド（Gemfile に従って bundle install が実行される）
docker compose build api
```

## 3. データベース接続の設定

`config/database.yml` の `host` を Docker 内の MySQL に合わせて設定するか、環境変数 `DATABASE_URL` を使用してください。

Docker Compose 利用時（コンテナ内）:
- host: `mysql`
- database: `jinro_boyz_rails_development`
- username: `jinro_boyz`
- password: `jinro_boyz`

ローカル実行時（`bin/rails s` をホストで実行）:
- host: `localhost`
- 上記と同様の database / username / password

## 5. データベースのセットアップ

```bash
# MySQL と Redis を起動
docker compose up -d mysql redis

# データベース作成・マイグレーション
docker compose run api bin/rails db:create db:migrate
```

※ マイグレーションファイルは既に作成済み（Devise / Users / Villages / Players / MainRooms / WolfRooms / DeadRooms / MainPosts / WolfPosts / DeadPosts / Records / Results / Profiles / JWT 用 jti カラム）。

## 6. 環境変数（認証用）

認証機能（JWT）を使用する場合、以下の環境変数を設定してください。

| 変数名 | 説明 | 例 |
|--------|------|-----|
| `DEVISE_JWT_SECRET_KEY` | JWT 署名用秘密鍵（未設定時は `secret_key_base` を使用） | `rails secret` で生成 |
| `CORS_ORIGINS` | CORS 許可オリジン（カンマ区切り） | `http://localhost:5173` |

## 7. サーバー起動

```bash
# ローカルで Rails を起動する場合
bundle install
bin/rails s
```

## 8. テスト実行

```bash
# MySQL を起動してから
docker compose up -d mysql

# テスト用 DB の作成（初回のみ）
docker compose exec mysql mysql -uroot -pjinro_boyz -e "CREATE DATABASE IF NOT EXISTS jinro_boyz_rails_test; GRANT ALL ON jinro_boyz_rails_test.* TO 'jinro_boyz'@'%'; FLUSH PRIVILEGES;"

# RSpec の実行
docker compose run --no-deps -e RAILS_ENV=test -e DATABASE_URL=mysql2://jinro_boyz:jinro_boyz@mysql:3306/jinro_boyz_rails_test api bundle exec rspec
```
