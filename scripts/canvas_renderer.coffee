define [
  "jQuery"
  "cs!util"
],

($, Util) ->

  class CanvasRenderer


    constructor: ->
      @width  = 512
      @height = 256
      @$el = $("<canvas id='display' width='#{@width}' height='#{@height}' />")
      $('body').prepend @$el


    getContext: -> @$el[0].getContext('2d')


    renderBitmap: (buffer, width, height) ->
      context = @getContext()
      scaleX = @width / width
      scaleY = @height / height
      bitmap = new Uint8Array(buffer)

      context.fillStyle = "rgb(0, 0, 0)"
      context.fillRect(0, 0, @width, @height)
      context.fillStyle = "rgb(125, 125, 125)"

      image = $("<canvas width='64' height='32' />")[0]
      imageContext = image.getContext('2d')
      imageData    = imageContext.getImageData(0, 0, 64, 32)

      for y in [0..(height - 1)]
        for x in [0..(width - 1)]
          byte    = bitmap[Math.floor(x / 8) + ((width / 8) * y)]
          bitMask = Math.pow(2, 7 - (x % 8))
          bitOn   = byte & bitMask
          if bitOn
            imageData.data[(x * 4) + (4 * width * y)]     = 125
            imageData.data[(x * 4) + (4 * width * y) + 1] = 125
            imageData.data[(x * 4) + (4 * width * y) + 2] = 125
            imageData.data[(x * 4) + (4 * width * y) + 3] = 255

      context.scale(scaleX, scaleY)
      imageContext.putImageData(imageData, 0, 0)
      context.drawImage(image, 0, 0)
