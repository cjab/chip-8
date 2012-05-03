define [
  "cs!disassembler"
  "cs!views/main"
],

(Disassembler, MainView) ->

  initialize = ->
    mainView = new MainView(el: '.container')

  return initialize: initialize
