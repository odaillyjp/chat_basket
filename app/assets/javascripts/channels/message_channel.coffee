App.channels ||= {}
App.channels.messages = App.cable.subscriptions.create "MessagesChannel",
  connected: ->
    @followCurrentRoom()
    @currentUser = $('.current-user').data('id')

  received: (data) ->
    switch data['command']
      when 'appendMessage'
        @appendMessage(data['body'], data['user_id'])
      when 'changeRoomStatus'
        @changeRoomStatus(data['status'])
      when 'startGame'
        @changeGameStatus(data['game_body'], data['player_body'])
      when 'exitGame'
        @exitGame(data['winner'])
      else
        false

  followCurrentRoom: ->
    if roomId = $('.room').data('room-id')
      @perform 'follow', room_id: roomId
    else
      @perform 'unfollow'

  appendMessage: (body, userId) ->
    $('.messages').append(body)
    @scrollBottom()
    if userId == @currentUser
      $('.new-message__content').focus()

  changeRoomStatus: (status) ->
    switch status
      when 'creatingGame'
        @hideNewGameButton()
      else
        false

  hideNewGameButton: ->
    newGameForm = $('.room__new-game')
    newGameForm.addClass('room__new-game--disabled')
    newGameForm.removeClass('room__new-game')

  showNewGameButton: ->
    newGameForm = $('.room__new-game--disabled')
    newGameForm.addClass('room__new-game')
    newGameForm.removeClass('room__new-game--disabled')

  changeGameStatus: (gameBody, playerBody) ->
    $('.room__game').html(gameBody)
    $('.room__player').html(playerBody)

  exitGame: (winner) ->
    $('.room__game').html('')
    $('.room__player').html('')
    @showNewGameButton()

  scrollBottom: ->
    messagesArea = $('.messages')
    messagesArea.scrollTop(messagesArea[0].scrollHeight)
