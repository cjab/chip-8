define [
  "jQuery"
  "Underscore"
  "Backbone"
  "cs!views/editor"
  "cs!views/menu"
  "cs!models/program"
  "cs!lib/chip8"
  "text!templates/main.html"
],

($, _, Backbone, EditorView, MenuView, Program, Chip8, mainTemplate) ->

  class MainView extends Backbone.View

    template: _.template(mainTemplate)


    initialize: ->
      @model      = new Program unless @model?
      @editorView = new EditorView model: @model
      @menuView   = new MenuView   model: @model
      @emulator   = new Chip8
      @render()


    render: ->
      data = {}
      @$el.html @template(data)
      @$el.find(".editor").html @editorView.render()
      @$el.find("#menu").html   @menuView.render()
