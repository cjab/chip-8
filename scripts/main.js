require.config({
  paths: {
    CoffeeScript: "lib/coffeescript/coffeescript",
    cs:           "lib/require/cs",
    text:         "lib/require/text",
    order:        "lib/require/order",
  }
});

define([
  "cs!app"
], function(App) {
  App.initialize();
});
