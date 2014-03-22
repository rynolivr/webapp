Sequelize = require 'sequelize'

sequelize = new Sequelize process.env.DATABASE_NAME, "", "",
  dialect: 'postgres'
  host: 'localhost'
  port: 5432
  omitNull: true

module.exports = sequelize
