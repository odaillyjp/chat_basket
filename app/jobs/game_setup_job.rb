class GameSetupJob < ApplicationJob
  queue_as :default

  def perform(game)
    game.setup!
    game.broadcast_start_game_to_players
  end
end
