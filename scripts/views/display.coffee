define [
  "jQuery"
  "Underscore"
  "Backbone"
  "cs!models/program"
  "cs!lib/util"
  "cs!lib/chip8"
  "cs!lib/canvas_renderer"
],

($, _, Backbone, Program, Util, Chip8, CanvasRenderer) ->

  class DisplayView extends Backbone.View

    tagName: "canvas"
    id: "display"


    initialize: ->
      @model = new Program unless @model?
      @model.on "change:data", @onProgramChange
      @$el      = $("<canvas id='display' width='512' height='256' />")
      @renderer = new CanvasRenderer(@$el)
      @emulator = new Chip8(@renderer)


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


    render: ->
      console.log @$el
      @$el
