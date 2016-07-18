class AddGameIdToHands < ActiveRecord::Migration[5.0]
  def up
    add_column :hands, :game_id, :integer

    ActiveRecord::Base.connection.execute(<<-SQL
      UPDATE
        hands
      SET
        game_id = players.game_id
      FROM
        players
      WHERE
        players.id = hands.orner_id
      ;
    SQL
    )

    change_column_null :hands, :game_id, false
  end

  def down
    remove_column :hands, :game_id
  end
end
