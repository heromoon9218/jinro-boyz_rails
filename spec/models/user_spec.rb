# frozen_string_literal: true

require "rails_helper"

RSpec.describe User, type: :model do
  describe "validations" do
    it "is valid with valid attributes" do
      user = build(:user)
      expect(user).to be_valid
    end

    it "is invalid without username" do
      user = build(:user, username: nil)
      expect(user).not_to be_valid
      expect(user.errors[:username]).to include("can't be blank")
    end

    it "is invalid with username shorter than 1 character" do
      user = build(:user, username: "")
      expect(user).not_to be_valid
    end

    it "is invalid with username longer than 20 characters" do
      user = build(:user, username: "a" * 21)
      expect(user).not_to be_valid
      expect(user.errors[:username]).to include("is too long (maximum is 20 characters)")
    end

    it "is invalid with duplicate username" do
      create(:user, username: "sameuser")
      user = build(:user, username: "sameuser")
      expect(user).not_to be_valid
      expect(user.errors[:username]).to include("has already been taken")
    end
  end

  describe "#set_jti" do
    it "sets jti before create" do
      user = create(:user)
      expect(user.jti).to be_present
      expect(user.jti).to match(/\A[0-9a-f-]{36}\z/)
    end
  end

  describe "Devise authentication" do
    it "authenticates with factory password" do
      user = create(:user, password: "secret123")
      expect(user.valid_password?("secret123")).to be true
      expect(user.valid_password?("wrong")).to be false
    end
  end
end
