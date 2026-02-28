# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Conversation Guidelines

- 常に日本語で会話する

## Project Overview

**人狼BOYZ** バックエンド API。Rails 8.1 API モードで構築された人狼ゲームサーバー。

**Stack**: Ruby 4.0.1 / Rails 8.1.2 (API only) / MySQL 8.4.8 / Redis 8.6
**Auth**: Devise + devise-jwt（JTI revocation strategy）
**CORS**: `CORS_ORIGINS` 環境変数でオリジン制御（デフォルト: `http://localhost:5173`）

## Commands

```bash
# 依存サービス起動
docker compose up -d mysql redis

# サーバー起動（ローカル）
bin/rails s

# Lint（自動修正）
bin/rubocop -a

# テスト全件
bundle exec rspec

# 単一ファイル / 特定行
bundle exec rspec spec/models/user_spec.rb
bundle exec rspec spec/models/user_spec.rb:37

# セキュリティスキャン
bin/brakeman --no-pager
bin/bundler-audit

# Docker 上でテスト実行（test DB 初回作成後）
docker compose exec -e RAILS_ENV=test \
  -e DATABASE_URL=mysql2://jinro_boyz:jinro_boyz@mysql:3306/jinro_boyz_rails_test \
  api bundle exec rspec
```

### Mandatory post-edit checks

`.rb` ファイル編集後は必ず以下を実行し、違反・失敗がないことを確認する：

1. `bin/rubocop -a`
2. `bundle exec rspec`

## Architecture

### API Structure

すべてのエンドポイントは `/api/v1/` 名前空間以下に配置する（`config/routes.rb`）。
認証トークンは JWT Bearer トークンとして `Authorization` ヘッダで送受信する。CORS の `expose: %w[Authorization]` 設定済み（`config/initializers/cors.rb`）。

### Domain Model

| Entity | 説明 |
|--------|------|
| `User` | アプリ利用者。Devise + JWT 認証（JTI で revocation 管理） |
| `Village` | 1ゲーム単位。`not_started → in_play → ended / ruined` |
| `Player` | Village に参加した User。役職・生死状態を持つ |
| `MainRoom` | 全生存者が参加するメインチャット（Village ごとに 1 つ） |
| `WolfRoom` | 人狼専用チャット（Village ごとに 1 つ） |
| `DeadRoom` | 死亡者専用チャット（Village ごとに 1 つ） |
| `Post` | 各ルームのチャット投稿 |
| `Record` | プレイヤーの日次アクション（投票・襲撃・占い・護衛） |
| `Result` | 日次の確定結果（処刑者・犠牲者・占い結果） |

Room は `room_type` による単一テーブル設計ではなく、**MainRoom / WolfRoom / DeadRoom の 3 つの独立エンティティ**として定義している（jinro_rails との主要な差異）。

### Test Setup

- `spec/factories/` — FactoryBot ファクトリ
- `spec/support/` — 共通ヘルパー（`rails_helper.rb` が自動 require）
- Database Cleaner: `type: :request` スペックは `:truncation`、それ以外は `:transaction`

### Environment Variables

| 変数名 | 説明 |
|--------|------|
| `DEVISE_JWT_SECRET_KEY` | JWT 署名用秘密鍵（未設定時は `secret_key_base` を使用） |
| `CORS_ORIGINS` | CORS 許可オリジン（カンマ区切り） |
| `DATABASE_URL` | DB 接続 URL（Docker 使用時） |
