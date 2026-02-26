# AGENTS.md

## Cursor Cloud specific instructions

This is a Ruby on Rails 8.1.2 API application (人狼BOYZ - Werewolf game backend) using Ruby 4.0.1, MySQL 8.4, and optionally Redis.

### Services

All services run via Docker Compose (`compose.yaml`):

| Service | Container | Port | Required |
|---------|-----------|------|----------|
| Rails API (Puma) | jinro-boyz-rails-api | 3000 | Yes |
| MySQL 8.4 | jinro-boyz-rails-mysql | 3306 | Yes |
| Redis 8.6 | jinro-boyz-rails-redis | 6379 | No (dev uses async adapter) |

### Starting the environment

Docker must be running first (`sudo dockerd &` if not started). Then:

```bash
sudo docker compose up -d mysql redis
# Wait for MySQL health check to pass (~5s)
sudo docker compose up -d api
```

### Database setup (first time only)

```bash
sudo docker compose run --rm -e DATABASE_URL=mysql2://jinro_boyz:jinro_boyz@mysql:3306/jinro_boyz_rails_development api bin/rails db:create db:migrate
sudo docker exec jinro-boyz-rails-mysql mysql -uroot -pjinro_boyz -e "CREATE DATABASE IF NOT EXISTS jinro_boyz_rails_test; GRANT ALL ON jinro_boyz_rails_test.* TO 'jinro_boyz'@'%'; FLUSH PRIVILEGES;"
sudo docker compose run --rm -e RAILS_ENV=test -e DATABASE_URL=mysql2://jinro_boyz:jinro_boyz@mysql:3306/jinro_boyz_rails_test api bin/rails db:schema:load
```

### Running checks

See `SETUP.md` for the full documented workflow. Quick reference:

- **Lint:** `sudo docker compose run --rm api bin/rubocop`
- **Tests:** `sudo docker compose run --rm -e RAILS_ENV=test -e DATABASE_URL=mysql2://jinro_boyz:jinro_boyz@mysql:3306/jinro_boyz_rails_test api bundle exec rspec`
- **Security (Brakeman):** `sudo docker compose run --rm api bin/brakeman --no-pager`
- **Security (bundler-audit):** `sudo docker compose run --rm api bin/bundler-audit`

### Gotchas

- The Docker daemon must be started manually in this cloud VM environment (`sudo dockerd &`) since systemd is not available.
- All `docker` and `docker compose` commands require `sudo`.
- The `DATABASE_URL` env var overrides `config/database.yml` settings. When running test commands, always pass `-e DATABASE_URL=mysql2://jinro_boyz:jinro_boyz@mysql:3306/jinro_boyz_rails_test`.
- The API is in early development: only the health check endpoint (`GET /up`) and model layer (User, Village, Player, etc.) exist. No API controllers have been created yet beyond `ApplicationController`.
- The `compose.yaml` volume-mounts the workspace into `/app` in the container, so code changes are reflected immediately without rebuilding. However, `Gemfile` changes require `sudo docker compose build api`.
