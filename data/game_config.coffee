define [
],

() ->

  "blinky.bin":
    url:    "data/blinky.bin"
    name:   "Blinky"
    keyMap:
      0x3: "up"
      0x6: "down"
      0x7: "left"
      0x8: "right"


  "pong.bin":
    url:    "data/pong.bin"
    name:   "Pong"
    keyMap:
      # Left player
      0x1: "w"
      0x4: "s"
      # Right player
      0xc: "up"
      0xd: "down"


  "maze.bin":
    url:    "data/maze.bin"
    name:   "Maze"
    keyMap: {}
