class Game < ApplicationRecord
  belongs_to :room
  belongs_to :winner, class_name: User

  validates :room_id, presence: true
  validates :stock, presence: true

  def setup!(*args)
    # TODO
  end
end
