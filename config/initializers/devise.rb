# frozen_string_literal: true

require Rails.root.join("lib", "devise_jwt_failure_app")

# Use this hook to configure devise mailer, warden hooks and so forth.
Devise.setup do |config|
  require "devise/orm/active_record"

  config.mailer_sender = "noreply@example.com"

  config.case_insensitive_keys = [ :email ]
  config.strip_whitespace_keys = [ :email ]

  # API-only: skip session storage for JWT auth
  config.skip_session_storage = [ :http_auth, :params_auth, :token_auth, :cookie ]
  config.navigational_formats = []

  config.stretches = Rails.env.test? ? 1 : 11
  config.password_length = 6..128
  config.email_regexp = /\A[^@\s]+@[^@\s]+\z/

  config.reconfirmable = true
  config.expire_all_remember_me_on_sign_out = true
  config.reset_password_within = 6.hours

  config.lock_strategy = :none
  config.unlock_strategy = :none

  config.sign_out_via = :delete

  config.jwt do |jwt|
    jwt.secret = ENV.fetch("DEVISE_JWT_SECRET_KEY", Rails.application.secret_key_base)
    jwt.dispatch_requests = [
      [ "POST", %r{^/api/v1/users/sign_in$} ],
      [ "POST", %r{^/api/v1/users$} ]
    ]
    jwt.revocation_requests = [
      [ "DELETE", %r{^/api/v1/users/sign_out$} ]
    ]
    jwt.expiration_time = 1.day.to_i
  end

  config.warden do |manager|
    manager.failure_app = DeviseJwtFailureApp
    manager.scope_defaults :user, store: false
  end
end
