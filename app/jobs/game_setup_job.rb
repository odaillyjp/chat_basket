class GameSetupJob < ApplicationJob
  queue_as :default

  def perform(game)
    game.setup!
  end
end
