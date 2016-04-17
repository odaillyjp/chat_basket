class Player < ApplicationRecord
  belongs_to :user
  belongs_to :game

  serialize :hand, JSON

  #def hands
  #  @hands ||= (hand ? JSON.parse(hand) : nil)
  #end

  def hands=(chars)
    @hands = chars
    set_json_hand_from_hands
  end

  def has_hand?(char)
    hands.include?(char)
  end

  def remove_hand(char)
    idx = hands.index(char)
    return nil unless idx

    hands.delete_at(idx)
    set_json_hand_from_hands
  end

  private

  def set_json_hand_from_hands
    self.hand = hands.to_json
  end
end
