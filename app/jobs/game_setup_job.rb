class GameSetupJob < ApplicationJob
  queue_as :default

  def perform(game)
    game.setup!
    game.broadcast_playing_status_to_players
  end
end
