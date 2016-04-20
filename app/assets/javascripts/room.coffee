$ ->
  $('.room__player').on 'click', '.player__hand-selector', ->
    selectedLink = $(@)
    $('.new-message__selected-hand-id').val(selectedLink.data('hand-id'))
    $('.player__hand-selector_selected').addClass('player__hand-selector').removeClass('player__hand-selector_selected')
    selectedLink.addClass('player__hand-selector_selected').removeClass('player__hand-selector')
    $('.new-message__content').focus()
    false

  $('.room__player').on 'click', '.player__hand-selector_selected', ->
    false
