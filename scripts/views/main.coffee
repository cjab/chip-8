define [
  "jQuery"
  "Underscore"
  "Backbone"
  "cs!views/editor"
  "cs!views/menu"
  "cs!views/display"
  "cs!models/program"
  "cs!lib/chip8"
  "text!templates/main.html"
],

($, _, Backbone, EditorView, MenuView, DisplayView, Program, Chip8, mainTemplate) ->

  class MainView extends Backbone.View

    template: _.template(mainTemplate)


    initialize: ->
      @program  = @options["program"]
      @renderer = @options["renderer"]
      @emulator = @options["emulator"]

      @displayView = new DisplayView  model: @renderer
      @menuView    = new MenuView     model: @program, emulator: @emulator

      @render()


    render: ->
      data = {}
      @$el.html @template(data)
      @$el.find("#menu").html    @menuView.render()
      @$el.find("#display").html @displayView.render()
