require 'coffee-script'
require 'node-env-file'

require('zappajs') ->

  # load custom configuration for modules
  # and assign it to `this`.
  @[name] = require "./#{name}" for name in [
    'passport'
  ]

  # load app configuration scripts.
  require("./startup/#{name}").call(this) for name in [
    'config'
    'middleware'
    'routes'
  ]
