define [
  "jQuery"
  "Underscore"
  "Backbone"
  "cs!models/program"
  "cs!lib/util"
  "cs!lib/chip8"
  "cs!lib/canvas_renderer"
  "cs!lib/dom_renderer"
],

($, _, Backbone, Program, Util, Chip8, CanvasRenderer, DOMRenderer) ->

  class DisplayView extends Backbone.View

    tagName: "canvas"
    id: "display"


    initialize: ->
      @model = new Program unless @model?
      @model.on "change:data", @onProgramChange
      # Default to DOMRenderer
      @renderer = new DOMRenderer
      @emulator = new Chip8(@renderer)
      @$el      = @renderer.$el


    onProgramChange: =>
      @emulator.reset()
      @emulator.load Util.flipEndianess(@model.get("data"))
      @emulator.run()


    hide: ->
      @hidden = true
      @$el.hide()


    show: ->
      @hidden = false
      @$el.show()


    render: -> @$el
