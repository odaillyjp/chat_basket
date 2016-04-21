class Game < ApplicationRecord
  belongs_to :room
  belongs_to :winner, class_name: 'Player', optional: true
  has_many   :players
  has_many   :layouts
  has_one    :top_layout, -> { order(created_at: :desc) }, class_name: 'Layout'

  def broadcast_status_to_players
    players.each do |player|
      ActionCable.server.broadcast "rooms:#{room_id}:users:#{player.user_id}",
        command: 'startGame',
        game_body: GamesController.render(partial: 'games/game', locals: { game: self }),
        player_body: PlayersController.render(partial: 'players/player', locals: { game: self, player: player })
    end
  end

  def enqueue_setup!
    GameSetupJob.perform_later(self)
  end

  def find_player_by_user(user)
    players.find_by(user: user)
  end

  def playing?
    top_layout && !winner_id
  end

  def play_card!(user, hand, word_name)
    with_lock do
      # NOTE:
      # - プレイヤーはゲームに参加していること
      # - プレイヤーは選択した文字のカードを持っていること
      # - ゲームが終了していないこと
      # - 単語が有効であること
      #   - 単語の始まりが場札の文字であり、かつ、単語の終わりが選択した文字であること
      #   - 単語が3文字以上であること（ラスト1枚は4文字以上）
      player = find_player_by_user(user)
      raise unless player
      raise unless player.has_hand?(hand)
      raise unless playing?
      raise unless valid_word?(word_name, hand.char, player)

      layouts.create(orner: player, char: hand.char, word: word_name)
      player.remove_hand!(hand)

      # NOTE: 終了条件の確認
      if player.grab_victory?
        self.winner = player
        save!

        room.update_attributes(current_game_id: nil)
      end
    end

    # NOTE: メッセージの保存
    message = room.messages.build(content: word_name)
    message.user = user
    message.save!
  end

  def setup!
    ActiveRecord::Base.transaction do
      cards = Card.all.shuffle

      # NOTE: プレイヤーに5枚のカードを配布
      players.each do |player|
        hands = cards.shift(5).map { |card| Hand.new(orner: player, char: card) }
        Hand.import(hands)
      end

      # NOTE: 最初の場札として1枚を出す
      card = cards.shift
      layouts.create(char: card)

      # NOTE: 残りのカードを山札とする
      self.stock = cards.to_json
      save!
    end
  end

  def valid_word?(word_name, last_char, player)
     word = Word.new(word_name)
     return false unless word.head == top_layout.char
     return false unless word.last == last_char

     min_length = (player.reaching? ? 4 : 3)
     word.length >= min_length
  end
end
