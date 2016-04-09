class Game < ApplicationRecord
  belongs_to :room
  belongs_to :winner, class_name: User, optional: true
  has_many   :players
  has_many   :layouts

  validates :room_id, presence: true

  scope :without_gameover, -> { where(winner_id: nil) }

  def enqueue_setup
    GameSetupJob.perform_later(self)
  end

  def setup!
    ActiveRecord::Base.transaction do
      cards = Card.all.shuffle

      # NOTE: プレイヤーに5枚のカードを配布
      self.players.each do |player|
        player.hand = cards.shift(5).to_json
        player.save!
      end

      # NOTE: 最初の場札として1枚を出す
      card = cards.shift
      self.layouts.create(char: card)

      # NOTE: 残りのカードを山札とする
      self.stock = cards.to_json
      save!
    end
  end
end
