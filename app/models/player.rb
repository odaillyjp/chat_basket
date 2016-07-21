class Player < ApplicationRecord
  belongs_to :user
  belongs_to :game
  has_many   :hands, foreign_key: :orner_id

  delegate :name, to: :user

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

  def reset_hands!(hands)
    with_lock do
      reset_count = hands.size + 1
      hands.delete_all
      cards = JSON.parse(self.game.stock)
      Hand.import(cards.shift(reset_count).map { |card| Hand.new(orner: self, char: card, game: self.game) })
      self.game.stock = cards.to_json
      self.game.save!
    end
  end
end
