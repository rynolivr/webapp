GitHub = require '../github'
async = require 'async'
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
    if req.user?
      Repo.find(where: _.pick(req.body, 'name', 'owner')).success (repo) ->
        repo.updateAttributes
          fixer_id: req.user.username
          status: if req.body.offensive then 'fixed' else 'fix not needed'
  count: (req, res) ->
    queries =
      pull_requests: Repo.count(where: status: 'fixed')

    async.map _.pairs(queries),
      (q, done) -> q[1].success (results) -> done(null, [q[0], results])
      (error, results) -> res.send _.zipObject results
