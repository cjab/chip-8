define [
  "jQuery"
  "Underscore"
  "Backbone"
  "cs!views/menu"
  "cs!views/display"
  "cs!lib/chip8"
  "text!templates/main.html"
],

($, _, Backbone, MenuView, DisplayView, Chip8, mainTemplate) ->

  class MainView extends Backbone.View

    template: _.template(mainTemplate)


    initialize: ->
      @renderer = @options["renderer"]
      @emulator = @options["emulator"]

      @displayView = new DisplayView  model: @renderer
      @menuView    = new MenuView     emulator: @emulator

      @render()


    render: ->
      data = {}
      @$el.html @template(data)
      @$el.find("#menu").html    @menuView.render()
      @$el.find("#display").html @displayView.render()
