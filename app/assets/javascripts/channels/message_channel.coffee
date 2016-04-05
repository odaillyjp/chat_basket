App.messages = App.cable.subscriptions.create "MessagesChannel",
  connected: ->
    @followCurrentRoom()

  received: (data) ->
    $('.messages').append(data['body'])

  followCurrentRoom: ->
    if roomId = $('.room').data('room-id')
      @perform 'follow', room_id: roomId
    else
      @perform 'unfollow'
