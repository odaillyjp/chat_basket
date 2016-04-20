$ ->
  $('.new-message').on 'ajax:success', ->
    $('.new-message__content').val('')
    $('.new-message__selected-hand-id').val('')
