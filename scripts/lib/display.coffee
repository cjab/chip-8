define [
],

() ->

  class Display

    @WIDTH:  64 # pixels
    @HEIGHT: 32 # pixels

    @FONT_HEIGHT: 5

    @FONTS:
      0: [ 0xf0, 0x90, 0x90, 0x90, 0xf0 ]
      1: [ 0x20, 0x60, 0x20, 0x20, 0x70 ]
      2: [ 0xf0, 0x10, 0xf0, 0x80, 0xf0 ]
      3: [ 0xf0, 0x10, 0xf0, 0x10, 0xf0 ]
      4: [ 0x90, 0x90, 0xf0, 0x10, 0x10 ]
      5: [ 0xf0, 0x80, 0xf0, 0x10, 0xf0 ]
      6: [ 0xf0, 0x80, 0xf0, 0x90, 0xf0 ]
      7: [ 0xf0, 0x10, 0x20, 0x40, 0x40 ]
      8: [ 0xf0, 0x90, 0xf0, 0x90, 0xf0 ]
      9: [ 0xf0, 0x90, 0xf0, 0x10, 0xf0 ]
      A: [ 0xf0, 0x90, 0xf0, 0x90, 0x90 ]
      B: [ 0xe0, 0x90, 0xe0, 0x90, 0xe0 ]
      C: [ 0xf0, 0x80, 0x80, 0x80, 0xf0 ]
      D: [ 0xe0, 0x90, 0x90, 0x90, 0xe0 ]
      E: [ 0xf0, 0x80, 0xf0, 0x80, 0xf0 ]
      F: [ 0xf0, 0x80, 0xf0, 0x80, 0x80 ]


    constructor: (@renderer, @width = Display.WIDTH, @height = Display.HEIGHT) ->
      @buffer = new Uint8Array(new ArrayBuffer((@width / 8) * @height))


    buildFonts: ->
      @fonts = new Uint8Array(new ArrayBuffer(Display.FONT_HEIGHT * 16))
      data = []
      data = data.concat(font) for own name, font of Display.FONTS
      data


    render: ->
      @renderer.renderBitmap @buffer.buffer, Display.WIDTH, Display.HEIGHT


    size: -> @byteWidth() * @height


    byteWidth: -> @width / 8


    isClear: ->
      result = 0
      result += byte for byte in @buffer
      !result


    clear: -> @buffer[i] = 0x00 for i in [0..@size()]


    byteOffset: (x, y) -> (y * @byteWidth()) + Math.floor(x / 8)


    bitOffset: (x, y) -> x & 0x07


    drawSprite: (x, y, sprite) ->
      byteOffset   = @byteOffset(x, y)
      offsetSprite = new Uint16Array(@buildOffsetSprite(x, y, sprite))
      bufferView   = new DataView(@buffer.buffer)
      collision    = 0

      for i in [0..(sprite.byteLength - 1)]
        # Modulus size to create wrapping of sprites on the y-axis
        target     = (byteOffset + (i * @byteWidth())) % @size()
        spriteData = offsetSprite[i]

        if (target % @byteWidth()) == @byteWidth() - 1
          # This means that the sprite has wrapped to the other side of the
          # screen. The 16-bit wide sprite must be broken in half. One byte
          # should be drawn on each side of the screen.
          targetRight = target
          targetLeft  = target - (@byteWidth() - 1)
          existingRight = bufferView.getUint8(targetRight)
          existingLeft  = bufferView.getUint8(targetLeft)
          spriteDataRight = spriteData >>> 8
          spriteDataLeft  = spriteData & 0xff

          collision += existingLeft & spriteDataLeft
          collision += existingRight & spriteDataRight

          bufferView.setUint8(targetRight, existingRight ^ spriteDataRight)
          bufferView.setUint8(targetLeft, existingLeft ^ spriteDataLeft)

        else
          existing   = bufferView.getUint16(target)
          collision += existing & spriteData

          bufferView.setUint16(target, existing ^ spriteData)

      @render()
      !!collision


    buildOffsetSprite: (x, y, sprite) ->
      bitOffset = @bitOffset(x, y)
      sprite8   = new Uint8Array(sprite)
      sprite16  = new Uint16Array(new ArrayBuffer(2 * sprite.byteLength))
      sprite16[i] = ((byte << 8) >>> bitOffset) for byte, i in sprite8
      sprite16.buffer
