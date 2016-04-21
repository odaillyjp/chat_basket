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
        @showPlayerStatus(data['body'])
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

  showPlayerStatus: (body) ->
    $('.room__player').html(body)

  scrollBottom: ->
    messagesArea = $('.messages')
    messagesArea.scrollTop(messagesArea[0].scrollHeight)
