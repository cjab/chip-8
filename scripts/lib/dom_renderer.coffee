define [
  "jQuery"
  "cs!lib/util"
],

($, Util) ->

  class DOMRenderer


    $el: $("<div class='display' />")


    constructor: () ->
      @width  = 64
      @height = 32
      @pixels = []

      @pixels[x] = [] for x in [0...@width]

      for y in [0...@height]
        row = $("<div class='pixel-row'>")
        for x in [0...@width]
          @pixels[x][y] = $("<div class='pixel' />").appendTo(row)
        @$el.append row



    renderBitmap: (buffer, width, height) ->
      scaleX = @width / width
      scaleY = @height / height
      bitmap = new Uint8Array(buffer)

      for y in [0...@height]
        for x in [0...@width]
          byte     = bitmap[Math.floor(x / 8) + ((width / 8) * y)]
          bitMask  = Math.pow(2, 7 - (x % 8))
          bitState = byte & bitMask
          @setPixel(x, y, bitState)



    setPixel: (x, y, value) ->
      if @pixels[x][y].hasClass("pixel-on") != !!value
        @pixels[x][y].toggleClass "pixel-on", !!value
