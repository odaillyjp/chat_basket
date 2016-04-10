class GameSetupJob < ApplicationJob
  queue_as :default

  def perform(game)
    game.setup!

    game.players.each do |player|
      ActionCable.server.broadcast "rooms:#{message.room_id}:users:#{player.id}",
        command: 'startGame',
        body: PlayersController.render(partial: 'players/show', locals: { game: game, player: player })
    end
  end
end
