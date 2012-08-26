define [
  "jQuery"
  "Underscore"
  "Backbone"
  "cs!views/game"
  "cs!models/game"
  "cs!collections/games"
  "cs!data/game_config"
],

($, _, Backbone, GameView, Game, Games, GameConfig) ->

  class GamesView extends Backbone.View

    id:        "games"

    tagName:   "ul"

    className: "dropdown-menu"


    initialize: ->
      @childViews = {}
      @collection = new Games

      @collection.on "add",      @onAdd
      @collection.on "remove",   @onRemove
      @collection.on "selected", @onSelected

      @collection.add new Game(config) for own key, config of GameConfig


    onAdd: (element) =>
      view = new GameView model: element
      @childViews[element.cid] = view


    onRemove: (element) =>
      @childViews[element.cid].remove()
      delete @childViews[element.cid]


    onSelected: (selected) =>
      @trigger "selected", selected


    render: ->
      games = (view.render() for own id, view of @childViews)
      @$el.html games
