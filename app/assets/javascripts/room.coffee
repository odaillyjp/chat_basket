$ ->
  $('.player__hands').on 'click', '.player__hand-selector', ->
    selectedLink = $(@)
    $('.new-message__selected-hand').val(selectedLink.data('char'))
    $('.player__hand-selector_selected').addClass('player__hand-selector').removeClass('player__hand-selector_selected')
    selectedLink.addClass('player__hand-selector_selected').removeClass('player__hand-selector')
    false

  $('.player__hands').on 'click', '.player__hand-selector_selected', ->
    false
