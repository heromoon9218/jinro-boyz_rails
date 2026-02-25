# frozen_string_literal: true

class CreateWolfRooms < ActiveRecord::Migration[8.1]
  def change
    create_table :wolf_rooms do |t|
      t.references :village, null: false, foreign_key: true

      t.timestamps
    end
  end
end
