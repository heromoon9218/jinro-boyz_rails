# frozen_string_literal: true

class CreateVillages < ActiveRecord::Migration[8.1]
  def change
    create_table :villages do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name, null: false
      t.integer :player_num, null: false
      t.integer :day, default: 0, null: false
      t.datetime :next_update_time
      t.integer :discussion_time, null: false
      t.integer :status, default: 0, null: false
      t.integer :winner
      t.datetime :start_at
      t.boolean :show_vote_target, default: true, null: false
      t.string :access_password

      t.timestamps
    end
  end
end
