({
  appDir:  "../",
  baseUrl: "scripts",
  dir:     "../build",
  paths: {
    cs:           "lib/require/csBuild",
    csBuild:      "lib/require/cs",
    CoffeeScript: "lib/coffeescript/coffeescript",
    text:         "lib/require/text",
    order:        "lib/require/order",
  },
  modules: [
    {
      name: "main",
      exclude: ["CoffeeScript"]
    }
  ]
})
