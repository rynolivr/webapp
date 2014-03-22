GitHub = require '../github'
_ = require 'lodash'

module.exports =
  list: (req, res) ->
    if req.user?
      res.render 'repos/list'
    else
      res.redirect '/login'
  next: (req, res) -> GitHub.next (repo) -> res.send repo
