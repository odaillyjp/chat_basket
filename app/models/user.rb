class User < ApplicationRecord
  validates :name, presence: true

  def join_game?(game)
    game.players.include?(user: self)
  end
end
