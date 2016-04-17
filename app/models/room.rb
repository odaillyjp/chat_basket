class Room < ApplicationRecord
  has_many :messages
  has_many :games
  has_many :attendances
  has_many :members, source: :user, through: :attendances

  belongs_to :current_game, class_name: 'Game', optional: true

  validates :name, presence: true

  def create_game!
    game = nil

    with_lock do
      raise '準備中です' unless waiting?

      ActionCable.server.broadcast "rooms:#{id}:messages",
        command: 'changeRoomStatus',
        status:  'creatingGame'

      game = games.build
      members.map { |member| game.players.build(user: member) }
      game.save!
      self.current_game = game
      save!
    end

    game.enqueue_setup!
  end

  def member?(user)
    members.include?(user)
  end

  def waiting?
    !current_game_id
  end

  def playing_game?
    !!current_game.try(:playing?)
  end
end
