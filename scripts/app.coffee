define [
  "cs!lib/disassembler"
  "cs!lib/chip8"
  "cs!lib/dom_renderer"
  "cs!lib/canvas_renderer"
  "cs!models/program"
  "cs!views/main"
],

(Disassembler, Chip8, DOMRenderer, CanvasRenderer, Program, MainView) ->

  initialize = ->
    program  = new Program
    renderer = new DOMRenderer
    emulator = new Chip8(renderer)

    mainView = new MainView
      el:    'body#main'
      program:  program
      renderer: renderer
      emulator: emulator

  return initialize: initialize
