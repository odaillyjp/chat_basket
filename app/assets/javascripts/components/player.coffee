App.components ||= {}
App.components.player = Vue.extend
  data: ->
    id: null,
    hands: []

  ready: ->
    @id = @$el.dataset.id
    @hands = JSON.parse(@$el.dataset.hands)
    $(@$el).removeClass('player--preparing')

  methods:
    setHands: (handData) ->
      @hands = handData
