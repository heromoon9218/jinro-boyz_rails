# frozen_string_literal: true

class CreatePlayers < ActiveRecord::Migration[8.1]
  def change
    create_table :players do |t|
      t.references :user, null: false, foreign_key: true
      t.references :village, null: false, foreign_key: true
      t.integer :role, default: 0, null: false
      t.integer :status, default: 0, null: false
      t.string :username, null: false

      t.timestamps
    end
  end
end
