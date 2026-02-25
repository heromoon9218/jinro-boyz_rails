# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Api::V1::Registrations", type: :request do
  describe "POST /api/v1/users" do
    let(:user_attrs) { { email: "newuser@example.com", username: "newuser", password: "password123" } }

    it "creates user and returns 201" do
      post "/api/v1/users",
           params: { user: user_attrs }.to_json,
           headers: { "CONTENT_TYPE" => "application/json", "ACCEPT" => "application/json" }

      expect(response).to have_http_status(:created)
      json = response.parsed_body
      expect(json["user"]).to be_present
      expect(json["user"]["email"]).to eq("newuser@example.com")
      expect(json["user"]["username"]).to eq("newuser")
    end
  end
end
