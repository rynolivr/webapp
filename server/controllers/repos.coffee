GitHub = require '../github'
Repo = require '../models/repo'
_ = require 'lodash'

module.exports =
  list: (req, res) ->
    if req.user?
      res.render 'repos/list'
    else
      res.redirect '/login'
  next: (req, res) -> GitHub.next (repo) -> res.send repo
  fix: (req, res) ->
    res.end()
    Repo.find(where: id: req.body.id).success (repo) ->
      repo.updateAttributes
        fixer_id: req.user.username
        status: if req.body.offensive then 'fixed' else 'fix not needed'
