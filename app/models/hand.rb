class Hand < ApplicationRecord
  belongs_to :orner, class_name: 'Player'
  belongs_to :game
end
