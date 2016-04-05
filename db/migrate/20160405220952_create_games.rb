class CreateGames < ActiveRecord::Migration[5.0]
  def change
    create_table :games do |t|
      t.references :room, foreign_key: true, null: false
      t.string     :stock, null: false
      t.integer    :winner_id, index: true

      t.timestamps
    end
  end
end
