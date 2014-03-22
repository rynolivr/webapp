require('node-env-file')("#{__dirname}/.env")

request = require 'request'
fs      = require 'fs'
_       = require 'lodash'
Repo    = require './models/repo'

path = fs.realpathSync("#{__dirname}/../terms.txt")
terms = fs.readFileSync(path).toString().split(/\n/)
terms.pop() unless _.last(terms)

module.exports =
  next: (callback) ->
    # TODO: load next result from queue

    Repo.find(where: status: 'queued').success (repo) =>
      if repo
        callback(repo)
      else
        @loadNextRepos => @next(callback)

  loadNextRepos: (callback = ->) ->
    word = @nextWord()

    request
      uri: "https://www.kimonolabs.com/api/4ig21rzm"
      qs:
        apikey: process.env.KIMONO_API_KEY
        q: word

    , (error, response, body) ->
      repos = JSON.parse(body).results.collection1.map (e) ->
        owner: e.repo.text.split('/')[0]
        name: e.repo.text.split('/')[1]
        matched: word
        status: "queued"
        file: e.filename.href

      # Repo.add repos, -> cb?(repos)
      Repo.bulkCreate(repos).success(callback)

  pageNumber: -> if @counter? then @counter / terms.length else 0

  nextWord: ->
    @counter ?= 0
    terms[@counter++ % terms.length]
