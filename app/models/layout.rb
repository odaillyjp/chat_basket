class Layout < ApplicationRecord
  belongs_to :game
  belongs_to :orner, class_name: User

  validates :game, presence: true
  validates :char, presence: true
  validates :orner_id, presence: true
end
