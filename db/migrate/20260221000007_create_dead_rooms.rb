# frozen_string_literal: true

class CreateDeadRooms < ActiveRecord::Migration[8.1]
  def change
    create_table :dead_rooms do |t|
      t.references :village, null: false, foreign_key: true

      t.timestamps
    end
  end
end
