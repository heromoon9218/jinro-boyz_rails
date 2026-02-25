source "https://rubygems.org"

gem "rails", "~> 8.1.2"
gem "mysql2", "~> 0.5.7"
gem "puma", "~> 7.2.0"
gem "devise", "~> 5.0.2"
gem "devise-jwt", "~> 0.13.0"
gem "rack-cors"
gem "tzinfo-data", platforms: %i[windows jruby]
gem "bootsnap", require: false
gem "thruster", "~> 0.1.18", require: false
gem "image_processing", "~> 1.14.0"

group :development, :test do
  gem "debug", "~> 1.11.1", platforms: %i[mri windows], require: "debug/prelude"
  gem "bundler-audit", "~> 0.9.3", require: false
  gem "brakeman", "~> 8.0.2", require: false
  gem "rubocop-rails-omakase", "~> 1.1.0", require: false
  gem "factory_bot_rails", "~> 6.4"
  gem "rspec-rails", "~> 8.0"
end

group :test do
  gem "database_cleaner-active_record", "~> 2.2"
  gem "simplecov", "~> 0.22", require: false
end
