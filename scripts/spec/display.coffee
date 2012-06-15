define [
  "cs!lib/display"
  "cs!lib/test_renderer"
],

(Display, TestRenderer) ->

  describe "Display", ->

    display = null

    beforeEach ->
      display = new Display(new TestRenderer)


    describe "#byteWidth", ->

      it "should return the number of bytes on the x-axis", ->
        expect(display.byteWidth()).toEqual(8)


    describe "#isClear", ->

      it "should return true if the screen buffer is empty (all 0's)", ->
        expect(display.isClear()).toBeTruthy()

      it "should return false if the screen buffer is not empty", ->
        display.buffer[0] = 0xff
        expect(display.isClear()).toBeFalsy()


    describe "#clear", ->

      it "should set all bits in the display buffer to 0", ->
        display.buffer[i] = 0xff for i in [0..display.size()]
        display.clear()
        result = 0
        result += i for i in display.buffer
        expect(result).toEqual(0)


    describe "#size", ->

      it "should return the size (in bytes) of the display buffer", ->
        expect(display.size()).toEqual((Display.WIDTH / 8) * Display.HEIGHT)


    describe "#byteOffset", ->

      it "should return the byte offset given the (x, y) coordinates of a pixel", ->
        expect(display.byteOffset(10, 1)).toEqual 9


    describe "#bitOffset", ->

      it "should return the offset from a byte boundary given an (x, y) coord", ->
        expect(display.bitOffset(10, 1)).toEqual 2


    describe "#drawSprite", ->

      describe "without wrapping", ->

        it "should draw a sprite to the display buffer", ->
          sprite = new Uint8Array(new ArrayBuffer(5))
          sprite.set [ 0xf0, 0x90, 0x90, 0x90, 0xf0 ]
          display.drawSprite(10, 1, sprite)
          expect(display.buffer[((display.width / 8) * 1) + 1]).toEqual 0x3c
          expect(display.buffer[((display.width / 8) * 2) + 1]).toEqual 0x24
          expect(display.buffer[((display.width / 8) * 3) + 1]).toEqual 0x24
          expect(display.buffer[((display.width / 8) * 4) + 1]).toEqual 0x24
          expect(display.buffer[((display.width / 8) * 5) + 1]).toEqual 0x3c

        it "should return false if there is no collision", ->
          sprite = new Uint8Array(new ArrayBuffer(5))
          sprite.set [ 0xf0, 0x90, 0x90, 0x90, 0xf0 ]
          expect(display.drawSprite(10, 1, sprite)).toBeFalsy()

        it "should return true if there is a collision", ->
          display.buffer[(display.width / 8) + 1] = 0xff
          sprite = new Uint8Array(new ArrayBuffer(5))
          sprite.set [ 0xf0, 0x90, 0x90, 0x90, 0xf0 ]
          expect(display.drawSprite(10, 1, sprite)).toBeTruthy()


      describe "WITH wrapping", ->

        it "should wrap a sprite on the x axis", ->
          sprite = new Uint8Array(new ArrayBuffer(5))
          sprite.set [ 0xff, 0xff, 0xff, 0xff, 0xff ]
          display.drawSprite(display.width - 1, 0, sprite)
          expect(display.buffer[0]).toEqual(0xfe)
          expect(display.buffer[(display.width / 8) - 1]).toEqual(0x01)

        it "should wrap a sprite on the y axis", ->
          sprite = new Uint8Array(new ArrayBuffer(5))
          sprite.set [ 0xff, 0xff, 0xff, 0xff, 0xff ]
          display.drawSprite(0, display.height - 1, sprite)
          expect(display.buffer[0]).toEqual(0xff)
          expect(display.buffer[(display.width / 8) * (display.height - 1)]).toEqual(0xff)

        it "should return false if there is no collision", ->
          sprite = new Uint8Array(new ArrayBuffer(5))
          sprite.set [ 0xff, 0xff, 0xff, 0xff, 0xff ]
          expect(display.drawSprite(display.width - 1, 0, sprite)).toBeFalsy()

        it "should return true if there is a collision", ->
          display.buffer[0] = 0xff
          sprite = new Uint8Array(new ArrayBuffer(5))
          sprite.set [ 0xff, 0xff, 0xff, 0xff, 0xff ]
          expect(display.drawSprite(display.width - 1, 0, sprite)).toBeTruthy()


    describe "#buildOffsetSprite", ->

      it "should build a new sprite offset for the correct coordinates", ->
        sprite = new Uint8Array(new ArrayBuffer(5))
        sprite.set [ 0xf0, 0x90, 0x90, 0x90, 0xf0 ]
        resultBuffer = display.buildOffsetSprite(9, 1, sprite)
        resultArray  = new Uint16Array(resultBuffer)
        expect(resultArray[0]).toEqual(0x7800)
        expect(resultArray[1]).toEqual(0x4800)
        expect(resultArray[2]).toEqual(0x4800)
        expect(resultArray[3]).toEqual(0x4800)
        expect(resultArray[4]).toEqual(0x7800)


    describe "#buildFonts", ->

      it "should build and return an array of font data", ->
        expect(display.buildFonts()[0]).toEqual(0xf0)
