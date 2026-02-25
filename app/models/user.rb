# frozen_string_literal: true

class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  validates :username, presence: true, length: { in: 1..20 }, uniqueness: true

  before_create :set_jti

  private

  def set_jti
    self.jti = SecureRandom.uuid
  end
end
