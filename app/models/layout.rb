class Layout < ApplicationRecord
  belongs_to :game
  belongs_to :orner, class_name: 'Player', optional: true

  validates :char, presence: true
end
