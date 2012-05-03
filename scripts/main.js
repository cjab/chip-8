require.config({
  paths: {
    jQuery:       "lib/jquery/jquery",
    Underscore:   "lib/underscore/underscore",
    Backbone:     "lib/backbone/backbone",
    CoffeeScript: "lib/coffeescript/coffeescript",
    bootstrap:    "lib/bootstrap/bootstrap",
    cs:           "lib/require/cs",
    text:         "lib/require/text",
    order:        "lib/require/order",
    templates:    "../templates"
  }
});

define([
  "cs!app",
  "order!lib/jquery/jquery-min",
  "order!lib/underscore/underscore-min",
  "order!lib/backbone/backbone-min",
  "order!lib/bootstrap/bootstrap-min"
], function(App) {
  App.initialize();
});
