class Room < ApplicationRecord
  has_many :messages
  has_many :games
  has_many :attendances
  has_many :members, source: :user, through: :attendances

  validates :name, presence: true
end
