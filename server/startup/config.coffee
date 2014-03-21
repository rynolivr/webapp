mongoose = require 'mongoose'
express = require 'express'
app = express.createServer()

module.exports = ->

  @set # use handlebars templating
    'view engine': 'hbs'
    'views': require('fs').realpathSync("#{__dirname}/../../views")

  app.configure ->
    app.set 'storage-uri', 'mongodb://localhost/repos'

  mongoose.connect app.get('storage-uri'), { db: { safe: true }}, (err) ->
    console.log "[ERROR]: Mongoose failed to connect" + err if err?
    console.log "[OK]: Mongoose connected"

  require '../model/repo'
