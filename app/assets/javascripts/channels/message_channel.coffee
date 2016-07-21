App.channels ||= {}
App.channels.messages = App.cable.subscriptions.create "MessagesChannel",
  connected: ->
    @install()
    @resetInstall()
    @followCurrentRoom()

  install: ->
    $(document).on 'turbolinks:load', =>
      @followCurrentRoom()
      @resetInstall()

  received: (data) ->
    @changeGameBody(data['game_body'])           if data['game_body']
    @changePlayerBody(data['player_body'])       if data['player_body']
    @bindCurrentPlayerHands(data['player_hand']) if data['player_hand']

    switch data['command']
      when 'appendMessage'
        @appendMessage(data['body'], data['user_id'])
      when 'changeRoomMembers'
        @changeRoomMembers(data['body'])
      when 'changeRoomStatus'
        @changeRoomStatus(data['status'])
      when 'startGame'
        @buildCurrentPlayer()
      when 'exitGame'
        @exitGame(data['winner'])
      else
        false

    if data['alertMessage']
      @showAlertMessage(data['alertMessage'])
    else if data['notifier']
      @changeNotifier(data['notifier'])

  resetInstall: ->
    $('.room__player').on 'ajax:success', '.reset-modal__form', (e, data, status, xhr) =>
      $('.player__reset-modal').addClass('player__reset-modal--hidden')
      @bindCurrentPlayerHands(data)

  followCurrentRoom: ->
    if roomId = $('.room').data('room-id')
      @buildCurrentPlayer()
      @perform 'follow', room_id: roomId
    else
      @currentPlayer = null
      @perform 'unfollow'

  appendMessage: (body, userId) ->
    $('.messages').append(body)
    @scrollBottom()

  bindCurrentPlayerHands: (handData) ->
    @currentPlayer.setHands(handData)

  changeGameBody: (body) ->
    $('.room__game').html(body)

  changePlayerBody: (body) ->
    $('.room__player').html(body)

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

  buildCurrentPlayer: ->
    @currentPlayer = new App.components.player({ el: '.player' })

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
