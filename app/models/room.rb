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

  def join_user!(user)
    self.attendances.create(user: user)

    ActionCable.server.broadcast "rooms:#{id}:messages",
      command: 'changeRoomMembers',
      body:    RoomsController.render(partial: 'rooms/members', locals: { room: self })
  end

  def member?(user)
    members.include?(user)
  end

  def leave_user!(user)
    self.attendances.find_by(user: user).try(:destroy)
    reload

    ActionCable.server.broadcast "rooms:#{id}:messages",
      command: 'changeRoomMembers',
      body:    RoomsController.render(partial: 'rooms/members', locals: { room: self })
  end

  def playing_game?
    !!current_game.try(:playing?)
  end

  def status
    if waiting?
      '待機中'
    elsif playing_game?
      'ゲーム中'
    else
      '準備中'
    end
  end

  def waiting?
    !current_game_id
  end
end
