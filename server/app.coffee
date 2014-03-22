require 'coffee-script'
require 'node-env-file'

app = require('zappajs') process.env.PORT or 3000, ->

  # load custom configuration for modules
  # and assign it to `this`.
  @[name] = require "./#{name}" for name in [
    'passport'
    'db'
  ]

  # load app configuration scripts.
  require("./startup/#{name}").call(this) for name in [
    'config'
    'middleware'
    'routes'
  ]
