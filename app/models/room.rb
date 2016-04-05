class Room < ApplicationRecord
  has_many :messages
  has_many :games

  validates :name, presence: true

  def members
    # TODO
  end
end
