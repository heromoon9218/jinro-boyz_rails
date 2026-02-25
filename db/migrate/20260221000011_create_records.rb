# frozen_string_literal: true

class CreateRecords < ActiveRecord::Migration[8.1]
  def change
    create_table :records do |t|
      t.references :village, null: false, foreign_key: true
      t.references :player, null: false, foreign_key: true
      t.integer :day, null: false
      t.references :vote_target, foreign_key: { to_table: :players }
      t.references :attack_target, foreign_key: { to_table: :players }
      t.references :divine_target, foreign_key: { to_table: :players }
      t.references :guard_target, foreign_key: { to_table: :players }

      t.timestamps
    end
  end
end
