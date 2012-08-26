define [
  "Underscore"
  "Backbone"
  "cs!models/game"
],

(_, Backbone, Game) ->

  class Games extends Backbone.Collection

    model: Game
