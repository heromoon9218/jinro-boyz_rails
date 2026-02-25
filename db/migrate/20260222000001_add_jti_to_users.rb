# frozen_string_literal: true

class AddJtiToUsers < ActiveRecord::Migration[8.1]
  def up
    add_column :users, :jti, :string
    execute "UPDATE users SET jti = REPLACE(UUID(), '-', '') WHERE jti IS NULL"
    change_column_null :users, :jti, false
    add_index :users, :jti, unique: true
  end

  def down
    remove_index :users, :jti
    remove_column :users, :jti
  end
end
