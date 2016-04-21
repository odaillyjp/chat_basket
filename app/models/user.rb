class User < ApplicationRecord
  validates :name, presence: true

  def join_game?(game)
    # NOTE: すでに players がロードされていることを考慮して、exists? は使わない
    game.players.any? { |player| player.user == self }
  end
end
