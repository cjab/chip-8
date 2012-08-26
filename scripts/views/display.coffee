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


    initialize: -> @$el = @model.$el


    render: -> @$el
