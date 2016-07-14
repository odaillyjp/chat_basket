$(document).on 'turbolinks:load', ->
  $('.room__player').on 'click', '.player__hand-selector', ->
    selectedLink = $(@)
    $('.new-message__selected-hand-id').val(selectedLink.data('hand-id'))
    $('.player__hand-selector--selected').removeClass('player__hand-selector--selected')
    selectedLink.addClass('player__hand-selector--selected')
    $('.new-message__content').focus()
    false

  $('.room__player').on 'click', '.player__hand-selector--selected', ->
    $('.new-message__content').focus()
    false

  init = ->
    messagesArea = $('.messages')
    if messagesArea.length > 0
      messagesArea.scrollTop(messagesArea[0].scrollHeight)
      $('.new-message__content').focus()

  init()
