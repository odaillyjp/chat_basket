class CreateHands < ActiveRecord::Migration[5.0]
  def change
    create_table :hands do |t|
      t.integer :orner_id, null: false, index: true
      t.string :char, null: false

      t.timestamps
    end

    remove_column :players, :hand, :string
  end
end
