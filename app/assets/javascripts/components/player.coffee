App.components ||= {}
App.components.player = Vue.extend
  data: ->
    id: null,
    hands: []

  ready: ->
    @id = @$el.dataset.id
    @hands = JSON.parse(@$el.dataset.hands)

  methods:
    setHands: (handData) ->
      @hands = handData
