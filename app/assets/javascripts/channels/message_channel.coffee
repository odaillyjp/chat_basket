App.channels ||= {}
App.channels.messages = App.cable.subscriptions.create "MessagesChannel",
  connected: ->
    @install()
    @followCurrentRoom()

  install: ->
    $(document).on 'turbolinks:load', =>
      @followCurrentRoom()

  received: (data) ->
    switch data['command']
      when 'appendMessage'
        @appendMessage(data['body'], data['user_id'])
      when 'changeRoomMembers'
        @changeRoomMembers(data['body'])
      when 'changeRoomStatus'
        @changeRoomStatus(data['status'])
      when 'startGame'
        @changeGameStatus(data['game_body'], data['player_body'])
      when 'exitGame'
        @exitGame(data['winner'])
      else
        false

    if data['alertMessage']
      @showAlertMessage(data['alertMessage'])
    else if data['notifier']
      @changeNotifier(data['notifier'])

  followCurrentRoom: ->
    if roomId = $('.room').data('room-id')
      @currentUser = $('.member--current').data('id')
      @perform 'follow', room_id: roomId
    else
      @currentUser = null
      @perform 'unfollow'

  appendMessage: (body, userId) ->
    $('.messages').append(body)
    @scrollBottom()
    $('.new-message__content').focus() if userId == @currentUser

  changeRoomMembers: (body) ->
    $('.room__members').html(body)

  changeRoomStatus: (status) ->
    switch status
      when 'creatingGame'
        @hideNewGameButton()
      else
        false

  hideNewGameButton: ->
    newGameForm = $('.room__new-game')
    newGameForm.addClass('room__new-game--disabled')

  showNewGameButton: ->
    newGameForm = $('.room__new-game--disabled')
    newGameForm.removeClass('room__new-game--disabled')

  changeGameStatus: (gameBody, playerBody) ->
    $('.room__game').html(gameBody)
    $('.room__player').html(playerBody)

  exitGame: (winner) ->
    $('.room__game').html('')
    $('.room__player').html('')
    @showNewGameButton()

  showAlertMessage: (message) ->
    $('.room__notifier').html("<div class='room-notifier__content--alert'>#{message}</div>")

  changeNotifier: (body) ->
    $('.room__notifier').html(body)

  scrollBottom: ->
    messagesArea = $('.messages')
    messagesArea.scrollTop(messagesArea[0].scrollHeight)
