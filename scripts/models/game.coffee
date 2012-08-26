define [
  "Underscore"
  "Backbone"
  "cs!lib/util"
  "cs!lib/chip8"
],

(_, Backbone, Util, Chip8) ->

  class Game extends Backbone.Model

    defaults:
      url:     ""
      name:    ""
      keyMap:  Chip8.DEFAULT_KEY_MAP
      program: null
