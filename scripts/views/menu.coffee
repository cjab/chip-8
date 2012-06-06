define [
  "jQuery"
  "Underscore"
  "Backbone"
  "text!templates/menu.html"
],

($, _, Backbone, menuTemplate) ->

  class MenuView extends Backbone.View

    template: _.template(menuTemplate)

    events: {}

    initialize: -> {}


    render: ->
      data =
        games: [
          "Blinky"
          "Pong"
        ]
      @$el.html @template(data)
      @$el
