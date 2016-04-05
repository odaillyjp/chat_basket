class CreateLayouts < ActiveRecord::Migration[5.0]
  def change
    create_table :layouts do |t|
      t.references :game, foreign_key: true, null: false
      t.string     :char, null: false
      t.integer    :orner_id, index: true, null: false

      t.timestamps
    end
  end
end
