# frozen_string_literal: true

class CreateDeadPosts < ActiveRecord::Migration[8.1]
  def change
    create_table :dead_posts do |t|
      t.references :player, foreign_key: true
      t.references :dead_room, null: false, foreign_key: true
      t.text :content, null: false
      t.integer :day, null: false
      t.integer :owner, default: 0, null: false

      t.timestamps
    end
  end
end
