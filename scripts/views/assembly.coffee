define [
  "jQuery"
  "Underscore"
  "Backbone"
  "cs!models/program"
],

($, _, Backbone, Program) ->

  class AssemblyView extends Backbone.View

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
      @model = new Program unless @model?
      @model.on "change:assembly", @onAssemblyChange


    onKeyUp:          => @model.set "assembly", @$el.val(), silent: true
    onAssemblyChange: => @$el.val @model.get("assembly")


    render: -> @$el
