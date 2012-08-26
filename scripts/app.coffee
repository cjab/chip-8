define [
  "cs!lib/disassembler"
  "cs!lib/chip8"
  "cs!lib/dom_renderer"
  "cs!lib/canvas_renderer"
  "cs!views/main"
],

(Disassembler, Chip8, DOMRenderer, CanvasRenderer, MainView) ->

  initialize = ->
    renderer = new DOMRenderer
    emulator = new Chip8(renderer)

    mainView = new MainView
      el:    'body#main'
      renderer: renderer
      emulator: emulator

  return initialize: initialize
