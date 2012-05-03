define [
  "jQuery"
  "Underscore"
  "Backbone"
  "cs!views/assembly"
  "cs!views/hex"
  "cs!models/program"
  "text!templates/editor.html"
],

($, _, Backbone, AssemblyView, HexView, Program, editorTemplate) ->

  class EditorView extends Backbone.View

    template: _.template(editorTemplate)

    events:
      "click a[href='#show-hex']":      "onShowHex"
      "click a[href='#show-assembly']": "onShowAssembly"


    initialize: ->
      @model = new Program unless @model?
      @assemblyView = new AssemblyView model: @model
      @hexView      = new HexView model: @model
      @hexView.hide()
      @assemblyView.show()


    onShowHex: =>
      @$el.find(".active").removeClass "active"
      @$el.find(".show-hex").addClass "active"
      @model.assemble()
      @assemblyView.hide()
      @hexView.show()


    onShowAssembly: =>
      @$el.find(".active").removeClass "active"
      @$el.find(".show-assembly").addClass "active"
      @hexView.hide()
      @assemblyView.show()


    render: ->
      data = {}
      @$el.html @template(data)
      @$el.find("#assembly-view").html @assemblyView.render()
      @$el.find("#hex-view").html @hexView.render()
      @$el
