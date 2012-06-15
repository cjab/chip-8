define [
  "jQuery"
  "Underscore"
  "Backbone"
  "cs!lib/util"
  "cs!views/editor"
  "cs!views/menu"
  "cs!models/program"
  "cs!lib/chip8"
  "text!templates/main.html"
],

($, _, Backbone, Util, EditorView, MenuView, Program, Chip8, mainTemplate) ->

  URL = window.webkitURL || window.URL
  BlobBuilder = window.BlobBuilder ||
    window.WebKitBlobBuilder || window.MozBlobBuilder

  class MainView extends Backbone.View

    template: _.template(mainTemplate)

    events:
      "click .download": "onDownload"
      "change .upload-assembly>input": "onUploadAssembly"
      "change .upload-binary>input":   "onUploadBinary"


    initialize: ->
      @model      = new Program unless @model?
      @editorView = new EditorView model: @model
      @menuView   = new MenuView
      @emulator   = new Chip8
      @render()
      @model.on "change:blob",     @onChangeBlob
      @model.on "change:assembly", @onChangeAssembly


    onUploadBinary: (e) =>
      input = @$el.find(".upload-binary>input")
      file = input.get(0).files[0]
      reader = new FileReader()
      buffer = null
      reader.onloadend = (e) =>
        @model.set "data", Util.flipEndianess(e.target.result)
      reader.readAsArrayBuffer(file)


    onUploadAssembly: (e) =>
      input = @$el.find(".upload-assembly>input")
      file = input.get(0).files[0]
      reader = new FileReader()
      buffer = null
      reader.onloadend = (e) => @model.set "assembly", e.target.result
      reader.readAsText(file)


    onDownload: (e) =>
      @model.assemble()
      @onChangeBlob()
      @onChangeAssembly()


    onChangeBlob: =>
      downloadBinary = @$el.find("a.download-binary")
      binaryUrl      = URL.createObjectURL @model.get("blob")
      downloadBinary.attr "href", binaryUrl
      downloadBinary.get(0).download = "out.bin"


    onChangeAssembly: =>
      downloadAssembly = @$el.find("a.download-assembly")
      blobBuilder = new BlobBuilder
      blobBuilder.append @model.get("assembly")
      assemblyUrl = URL.createObjectURL blobBuilder.getBlob("text/plain")
      downloadAssembly.attr "href", assemblyUrl
      downloadAssembly.get(0).download = "out.asm"


    render: ->
      data = {}
      @$el.html @template(data)
      @$el.find(".editor").html @editorView.render()
      @$el.find("#menu").html   @menuView.render()
