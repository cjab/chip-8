define [
  "jQuery"
  "Underscore"
  "Backbone"
  "cs!models/program"
],

($, _, Backbone, Program) ->

  class HexView extends Backbone.View

    tagName: "textarea"

    events:
      "keyup": "onKeyUp"


    hide: ->
      @hidden = true
      @$el.hide()


    show: ->
      @hidden = false
      @$el.show()


    initialize: ->
      @$el.prop "disabled", true
      @model = new Program unless @model?
      @model.on "change:hex", @onHexChange


    onKeyUp:     => @model.set "hex", @$el.val(), silent: true
    onHexChange: => @$el.val @model.get("hex")


    render: -> @$el
