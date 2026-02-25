# frozen_string_literal: true

class DeviseJwtFailureApp < Devise::FailureApp
  def respond
    if request.format == :json
      json_failure
    else
      super
    end
  end

  def json_failure
    self.status = 401
    self.content_type = "application/json"
    body = { error: i18n_message }
    body[:debug_params] = request.params.to_h if Rails.env.development? || Rails.env.test?
    self.response_body = body.to_json
  end
end
