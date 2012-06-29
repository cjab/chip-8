define [
  "jQuery"
  "Underscore"
  "Backbone"
  "cs!views/assembly"
  "cs!views/hex"
  "cs!views/display"
  "cs!models/program"
  "text!templates/editor.html"
],

($, _, Backbone, AssemblyView, HexView, DisplayView, Program, editorTemplate) ->

  class EditorView extends Backbone.View

    template: _.template(editorTemplate)

    events:
      "click a[href='#show-hex']":      "onShowHex"
      "click a[href='#show-display']":  "onShowDisplay"
      "click a[href='#show-assembly']": "onShowAssembly"


    initialize: ->
      @model = new Program unless @model?
      @displayView  = new DisplayView  model: @model
      @assemblyView = new AssemblyView model: @model
      @hexView      = new HexView      model: @model
      @hexView.hide()
      @assemblyView.hide()
      @displayView.show()


    onShowHex: =>
      @$el.find(".active").removeClass "active"
      @$el.find(".show-hex").addClass "active"
      @model.assemble()
      @displayView.hide()
      @assemblyView.hide()
      @hexView.show()


    onShowAssembly: =>
      @$el.find(".active").removeClass "active"
      @$el.find(".show-assembly").addClass "active"
      @displayView.hide()
      @hexView.hide()
      @assemblyView.show()


    onShowDisplay: =>
      @$el.find(".active").removeClass "active"
      @$el.find(".show-display").addClass "active"
      @hexView.hide()
      @assemblyView.hide()
      @displayView.show()


    render: ->
      data = {}
      @$el.html @template(data)
      @$el.find("#display-view").html  @displayView.render()
      @$el.find("#assembly-view").html @assemblyView.render()
      @$el.find("#hex-view").html      @hexView.render()
      @$el
