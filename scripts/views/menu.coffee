define [
  "jQuery"
  "Underscore"
  "Backbone"
  "cs!lib/util"
  "cs!lib/assembler"
  "cs!lib/disassembler"
  "cs!views/games"
  "cs!lib/chip8"
  "text!templates/menu.html"
],

($, _, Backbone, Util, Assembler, Disassembler, GamesView, Chip8, menuTemplate) ->

  class MenuView extends Backbone.View

    template: _.template(menuTemplate)


    events:
      "change .upload-assembly>input": "onUploadAssembly"
      "click .download": "onDownload"
      "change .upload-binary>input":   "onUploadBinary"


    initialize: ->
      @emulator     = @options["emulator"]
      @assembler    = new Assembler
      @disassembler = new Disassembler

      @gamesView = new GamesView
      @gamesView.on "selected", @onGameSelected


    runEmulator: (data, keyMap = Chip8.DEFAULT_KEY_MAP) =>
      @emulator.reset()
      @emulator.setKeyMap(keyMap)
      @emulator.load(data)
      @emulator.run()


    onGameSelected: (selected) =>
      console.log selected.get("program"), selected.get("keyMap")
      @runEmulator selected.get("program"), selected.get("keyMap")


    onUploadBinary: (e) =>
      input = @$el.find(".upload-binary>input")
      file = input.get(0).files[0]
      reader = new FileReader()
      buffer = null
      reader.onloadend = (e) =>
        @runEmulator e.target.result
      reader.readAsArrayBuffer(file)


    onUploadAssembly: (e) =>
      input = @$el.find(".upload-assembly>input")
      file = input.get(0).files[0]
      reader = new FileReader()
      buffer = null
      reader.onloadend = (e) =>
        @runEmulator @assembler.toArrayBuffer(e.target.result)
      reader.readAsText(file)


    onDownload: (e) =>
      if @emulator.currentProgram
        @_prepareBinary()
        @_prepareAssembly()


    _prepareBinary: =>
      downloadBinary = @$el.find("a.download-binary")
      blobBuilder    = new Util.BlobBuilder
      blobBuilder.append @emulator.currentProgram
      binaryUrl      = Util.URL.createObjectURL blobBuilder.getBlob("application/octet-stream")
      downloadBinary.attr "href", binaryUrl
      downloadBinary.get(0).download = "out.bin"


    _prepareAssembly: =>
      downloadAssembly = @$el.find("a.download-assembly")
      blobBuilder = new Util.BlobBuilder
      blobBuilder.append @disassembler.run(@emulator.currentProgram).join("\n")?.replace("\n\n", "")
      assemblyUrl = Util.URL.createObjectURL blobBuilder.getBlob("text/plain")
      downloadAssembly.attr "href", assemblyUrl
      downloadAssembly.get(0).download = "out.asm"


    render: ->
      data = {}
      @$el.html @template(data)
      @$el.find("#games").replaceWith @gamesView.render()
      @$el
