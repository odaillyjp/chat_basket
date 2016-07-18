class GameSetupJob < ApplicationJob
  queue_as :default

  def perform(game)
    game.setup!
    game.broadcast_game_start_to_players
  end
end
