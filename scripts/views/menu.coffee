define [
  "jQuery"
  "Underscore"
  "Backbone"
  "cs!lib/util"
  "text!templates/menu.html"
],

($, _, Backbone, Util, menuTemplate) ->

  class MenuView extends Backbone.View

    template: _.template(menuTemplate)


    events:
      "click .download": "onDownload"
      "change .upload-assembly>input": "onUploadAssembly"
      "change .upload-binary>input":   "onUploadBinary"


    initialize: ->
      @model.on "change:blob",     @onChangeBlob
      @model.on "change:assembly", @onChangeAssembly


    onUploadBinary: (e) =>
      input = @$el.find(".upload-binary>input")
      file = input.get(0).files[0]
      reader = new FileReader()
      buffer = null
      reader.onloadend = (e) =>
        console.log "HERE", @model
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
      binaryUrl      = Util.URL.createObjectURL @model.get("blob")
      downloadBinary.attr "href", binaryUrl
      downloadBinary.get(0).download = "out.bin"


    onChangeAssembly: =>
      downloadAssembly = @$el.find("a.download-assembly")
      blobBuilder = new Util.BlobBuilder
      blobBuilder.append @model.get("assembly")
      assemblyUrl = Util.URL.createObjectURL blobBuilder.getBlob("text/plain")
      downloadAssembly.attr "href", assemblyUrl
      downloadAssembly.get(0).download = "out.asm"


    render: ->
      data =
        games: [
          "Blinky"
          "Pong"
        ]
      @$el.html @template(data)
      @$el
