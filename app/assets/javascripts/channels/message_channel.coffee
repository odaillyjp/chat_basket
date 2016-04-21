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
        @hideNewGameForm()
      else
        false

  hideNewGameForm: ->
    newGameForm = $('.room__new-game')
    newGameForm.addClass('room__new-game--disabled')
    newGameForm.removeClass('room__new-game')

  changeGameStatus: (gameBody, playerBody) ->
    $('.room__game').html(gameBody)
    $('.room__player').html(playerBody)

  scrollBottom: ->
    messagesArea = $('.messages')
    messagesArea.scrollTop(messagesArea[0].scrollHeight)
