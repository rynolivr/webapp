Sequelize = require 'sequelize'

Repo = new Sequelize process.env.DATABASE_NAME, "", "",
  dialect: 'postgres'
  host: 'localhost'
  port: 5432

module.exports = Repo
