GitHub = require '../github'
_ = require 'lodash'

module.exports =
  list: (req, res) -> res.render 'repos/list'
  next: (req, res) -> GitHub.next (repo) -> res.send repo
