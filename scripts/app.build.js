({
  appDir:  "../",
  baseUrl: "scripts",
  dir:     "../build",
  paths: {
    cs:           "vendor/require/csBuild",
    csBuild:      "vendor/require/cs",
    CoffeeScript: "vendor/coffeescript/coffeescript",
    text:         "vendor/require/text",
    order:        "vendor/require/order",
  },
  modules: [
    {
      name: "main",
      exclude: ["CoffeeScript"]
    }
  ]
})
