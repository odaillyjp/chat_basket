class Attendance < ApplicationRecord
  belongs_to :room
  belongs_to :user

  validates :room_id, presence: true
  validates :user_id, presence: true
  validates :status,  presence: true

  enum status: %i(away active)
end
