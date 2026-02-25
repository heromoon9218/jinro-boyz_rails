# frozen_string_literal: true

class CreateResults < ActiveRecord::Migration[8.1]
  def change
    create_table :results do |t|
      t.references :village, null: false, foreign_key: true
      t.integer :day, null: false
      t.references :voted_player, foreign_key: { to_table: :players }
      t.references :attacked_player, foreign_key: { to_table: :players }
      t.references :divined_player, foreign_key: { to_table: :players }
      t.references :guarded_player, foreign_key: { to_table: :players }

      t.timestamps
    end
  end
end
