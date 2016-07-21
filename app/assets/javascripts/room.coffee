$(document).on 'turbolinks:load', ->
  $('.room__player').on 'click', '.player__hand-selector', ->
    selectedLink = $(@)
    $('.new-message__selected-hand-id').val(selectedLink.data('hand-id'))
    $('.player__hand-selector--selected').removeClass('player__hand-selector--selected')
    selectedLink.addClass('player__hand-selector--selected')
    $('.new-message__content').focus()
    false

  $('.room__player').on 'click', '.player__hand-selector--selected', ->
    false

  $('.room__player').on 'click', '.player__reset', ->
    $('.player__reset-modal').removeClass('player__reset-modal--hidden')
    false

  $('.room__player').on 'click', '.reset-modal__overlay', ->
    $('.player__reset-modal').addClass('player__reset-modal--hidden')
    false

  $('.room__player').on 'click', '.reset-modal__hand-selector', ->
    selectedLink = $(@)

    if selectedLink.hasClass('reset-modal__hand-selector--selected')
      $("#reset_hand_#{selectedLink.data('hand-id')}").remove()
      selectedLink.removeClass('reset-modal__hand-selector--selected')
    else
      $('.reset-modal__form').append("<input type='hidden' id='reset_hand_#{selectedLink.data('hand-id')}' name='hands[]' value='#{selectedLink.data('hand-id')}'>")
      selectedLink.addClass('reset-modal__hand-selector--selected')

    false

  init = ->
    messagesArea = $('.messages')
    if messagesArea.length > 0
      messagesArea.scrollTop(messagesArea[0].scrollHeight)
      $('.new-message__content').focus()

  init()
