define [
  "jQuery"
  "cs!lib/chip8"
  "cs!lib/util"
  "cs!lib/dom_renderer"
],

($, Chip8, Util, DOMRenderer) ->

  describe "DOMRenderer", ->

    it "should work", ->
      renderer = new DOMRenderer
      buffer = new ArrayBuffer(32 * 8)
      bitmap = new Uint8Array(buffer)
      bitmap[0]  = 0xf0
      bitmap[8]  = 0x90
      bitmap[16] = 0xf0
      bitmap[24] = 0x90
      bitmap[32] = 0x90

      bitmap[1]  = 0xe0
      bitmap[9]  = 0x90
      bitmap[17] = 0xe0
      bitmap[25] = 0x90
      bitmap[33] = 0xe0

      bitmap[2]  = 0xf0
      bitmap[10] = 0x80
      bitmap[18] = 0x80
      bitmap[26] = 0x80
      bitmap[34] = 0xf0

      bitmap[3]  = 0xe0
      bitmap[11] = 0x90
      bitmap[19] = 0x90
      bitmap[27] = 0x90
      bitmap[35] = 0xe0

      bitmap[4]  = 0xf0
      bitmap[12] = 0x80
      bitmap[20] = 0xf0
      bitmap[28] = 0x80
      bitmap[36] = 0xf0

      bitmap[5]  = 0xf0
      bitmap[13] = 0x80
      bitmap[21] = 0xf0
      bitmap[29] = 0x80
      bitmap[37] = 0x80

      renderer.renderBitmap(buffer, 64, 32)
      $("body").append renderer.$el
