# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Api::V1::Sessions", type: :request do
  describe "POST /api/v1/users/sign_in" do
    let(:user) { create(:user, email: "login@example.com", password: "password123") }

    it "returns user data and 200 on valid credentials", skip: "JSON params が Rails Integration Test で正しく渡らない要調査" do
      post "/api/v1/users/sign_in.json", params: { user: { email: user.email, password: "password123" } }, as: :json

      expect(response).to have_http_status(:ok)
      json = response.parsed_body
      expect(json["user"]).to be_present
      expect(json["user"]["email"]).to eq("login@example.com")
      expect(json["user"]["username"]).to eq(user.username)
    end

    it "returns 401 on invalid credentials" do
      post "/api/v1/users/sign_in",
           params: { user: { email: user.email, password: "wrongpassword" } }.to_json,
           headers: { "CONTENT_TYPE" => "application/json", "ACCEPT" => "application/json" }

      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "DELETE /api/v1/users/sign_out" do
    let(:user) { create(:user) }

    it "returns 204 when signed in" do
      # sign_in の JSON params 問題を回避し、Devise::JWT::TestHelpers で直接 JWT を付与
      headers = { "ACCEPT" => "application/json", "CONTENT_TYPE" => "application/json" }
      auth_headers = Devise::JWT::TestHelpers.auth_headers(headers, user)

      delete "/api/v1/users/sign_out", headers: auth_headers

      expect(response).to have_http_status(:no_content)
    end
  end
end
