mongoose = require 'mongoose'

Repo = new mongoose.Schema(
  owner: String
  name: String
  matched: String
  file: String
)

mongoose.model "Repo", Repo
