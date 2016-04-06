class CreatePlayers < ActiveRecord::Migration[5.0]
  def change
    create_table :players do |t|
      t.references :user, foreign_key: true, null: false
      t.references :game, foreign_key: true, null: false
      t.string     :hand

      t.timestamps
    end
  end
end
