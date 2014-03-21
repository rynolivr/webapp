mongoose = require 'mongoose'

Repo = new mongoose.Schema
  owner: String
  name: String
  matched: String
  status: String
  file: String

mongoose.model "Repo", Repo
