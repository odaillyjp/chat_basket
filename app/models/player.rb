class Player < ApplicationRecord
  belongs_to :user
  belongs_to :game
  has_many   :hands, foreign_key: :orner_id

  def grab_victory?
    hands.length == 0
  end

  def has_hand?(hand)
    hands.include?(hand)
  end

  def reaching?
    hands.length == 1
  end

  def remove_hand!(hand)
    hand.destroy!
    hands.reload
  end
end
