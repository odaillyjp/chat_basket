class Layout < ApplicationRecord
  belongs_to :game
  belongs_to :orner, class_name: User, optional: true

  validates :game, presence: true
  validates :char, presence: true
end
