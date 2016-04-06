class Player < ApplicationRecord
  belongs_to :user
  belongs_to :game

  validates :user, presence: true
  validates :game, presence: true
end
