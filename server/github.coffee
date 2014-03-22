require('node-env-file')("#{__dirname}/.env")

request = require 'request'
fs      = require 'fs'
_       = require 'lodash'
Repo    = require './models/repo'
async   = require 'async'

path = fs.realpathSync("#{__dirname}/../terms.txt")
terms = fs.readFileSync(path).toString().split(/\n/).filter (t) -> t

module.exports =
  next: (callback) ->
    Repo.find(where: status: 'queued').success (repo) =>
      if repo
        repo.updateAttributes(status: 'checking').success -> callback(repo)
      else
        @loadNextRepos => @next(callback)

  loadNextRepos: (callback = ->) ->
    word = @nextWord()
    page = @pageNumber()

    console.log("loading repos containing term '#{word}' (page #{page})")

    request
      uri: "https://www.kimonolabs.com/api/bpbspnvq"
      qs:
        apikey: process.env.KIMONO_API_KEY
        q: word
        p: page

    , (error, response, body) ->

      repos = JSON.parse(body).results.collection1.map (e) ->
        owner: e.repo.text.split('/')[0]
        name: e.repo.text.split('/')[1]
        matched: word
        status: "queued"
        file: e.filename.href

      ###
      can't use Sequelize bulkCreate because it tries to insert a null id which
      violates postgres serial non-null create

      did I ever mention I'm not a huge fan of sequelize?
      ###
      async.map repos,
        (repo, done) -> Repo.create(repo).success(done)
        callback

  pageNumber: -> if @counter? then parseInt(@counter / terms.length, 10) + 1 else 0

  nextWord: ->
    @counter ?= 0
    terms[@counter++ % terms.length]
