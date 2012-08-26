define [
  "jQuery"
  "Underscore"
  "Backbone"
  "text!templates/game.html"
],

($, _, Backbone, gameTemplate) ->

  class GameView extends Backbone.View

    tagName: "li"

    template: _.template(gameTemplate)

    events:
      "click": "onClick"


    onClick: (e) =>
      xhr = new XMLHttpRequest
      xhr.open "GET", e.target.href, true
      xhr.responseType = 'arraybuffer'
      xhr.onload = (evt) =>
        request = evt.target
        @model.set "program", request.response
        @model.trigger("selected", @model) if request.status is 200
      xhr.send()
      e.preventDefault()


    render: ->
      data =
        name:   @model.get "name"
        url:    @model.get "url"
        keyMap: @model.get "keyMap"
      @$el.html @template(data)
      @el
