Sequelize = require 'sequelize'
sequelize = require '../db'
async = require 'async'
_ = require 'lodash'

module.exports = Repo = sequelize.define 'Repo',
  owner: Sequelize.STRING
  name: Sequelize.STRING
  matched: Sequelize.STRING
  status: Sequelize.STRING
  file: Sequelize.STRING
  fixer: Sequelize.STRING
,
  underscored: true
  tableName: 'repos'

Repo.displayCounts = (callback) ->
  queries =
    pull_requests: @count(where: status: 'fixed')

  async.map _.pairs(queries),
    (q, done) -> q[1].success (results) -> done(null, [q[0], results])
    (error, results) -> callback _.zipObject results
