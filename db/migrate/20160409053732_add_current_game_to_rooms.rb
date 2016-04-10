class AddCurrentGameToRooms < ActiveRecord::Migration[5.0]
  def change
    add_column :rooms, :current_game_id, :integer
    add_index  :rooms, :current_game_id
  end
end
