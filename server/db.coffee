Sequelize = require 'sequelize'

Repo = new Sequelize 'rosspenman', '', '',
  dialect: 'postgres'
  host: 'localhost'
  port: 5432

module.exports = Repo
