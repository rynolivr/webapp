Sequelize = require 'sequelize'
sequelize = require '../db'

module.exports = sequelize.define 'Repo',
  owner: Sequelize.STRING
  name: Sequelize.STRING
  matched: Sequelize.STRING
  status: Sequelize.STRING
  file: Sequelize.STRING
  fixer: Sequelize.STRING
,
  underscored: true
  tableName: 'repos'
