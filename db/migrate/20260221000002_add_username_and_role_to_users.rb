# frozen_string_literal: true

class AddUsernameAndRoleToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :username, :string, null: false
    add_column :users, :role, :integer, null: false, default: 0

    add_index :users, :username, unique: true
  end
end
