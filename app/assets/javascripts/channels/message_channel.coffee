App.channels = {}
App.channels.messages = App.cable.subscriptions.create "MessagesChannel",
  connected: ->
    @followCurrentRoom()

  received: (data) ->
    switch data['command']
      when 'appendMessage'
        @appendMessage(data['body'])
      when 'changeRoomStatus'
        @changeRoomStatus(data['status'])
      else
        false

  followCurrentRoom: ->
    if roomId = $('.room').data('room-id')
      @perform 'follow', room_id: roomId
    else
      @perform 'unfollow'

  appendMessage: (body) ->
    $('.messages').append(body)

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
