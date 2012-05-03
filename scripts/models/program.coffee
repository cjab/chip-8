define [
  "Underscore"
  "Backbone"
	"cs!util"
  "cs!assembler"
  "cs!disassembler"
],

(_, Backbone, Util, Assembler, Disassembler) ->

  BlobBuilder = BlobBuilder || WebKitBlobBuilder || MozBlobBuilder

  class Program extends Backbone.Model

    assembler:    new Assembler()
    disassembler: new Disassembler()

    defaults:
      assembly: ""
      hex:      ""
      data:     new ArrayBuffer()
      blob:     null


    initialize: ->
      @on "change:data", @onChangeData


    onChangeData: =>
      @set "assembly", @disassemble().join("\n")


    assemble:    ->
      @set "data", @assembler.toArrayBuffer(@get("assembly"))
      @set "hex", ("0x#{i.toString(16)}" for i in new Uint16Array @get("data")).join("\n")
      blobBuilder = new BlobBuilder
      blobBuilder.append Util.flipEndianess(@get("data"))
      @set "blob", blobBuilder.getBlob("application/octet-stream")


    disassemble: ->
      @disassembler.run @get("data")
