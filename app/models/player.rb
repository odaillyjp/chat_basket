class Player < ApplicationRecord
  belongs_to :user
  belongs_to :game

  def hands
    JSON.parse(hand)
  end
end
