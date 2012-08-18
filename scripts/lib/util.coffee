define [
],

() ->

  class Util

    @URL:         window.webkitURL ||
                  window.URL

    @BlobBuilder: window.BlobBuilder ||
                  window.WebKitBlobBuilder ||
                  window.MozBlobBuilder


    @flipEndianess: (buffer) ->
      input         = new Uint16Array(buffer)
      flippedBuffer = new ArrayBuffer buffer.byteLength
      output        = new Uint16Array flippedBuffer
      output.set (((instr << 8) & 0xff00) | (instr >>> 8) for instr in input)
      flippedBuffer
