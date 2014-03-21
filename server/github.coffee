require('node-env-file')("#{__dirname}/.env")

request = require 'request'
fs      = require 'fs'
_       = require 'lodash'

path = fs.realpathSync("#{__dirname}/../terms.txt")
terms = fs.readFileSync(path).toString().split(/\n/)
terms.pop() unless _.last(terms)

GitHub =
  next: (callback) ->
    # TODO: load next result from queue

  loadNextRepos: (callback) ->
    word = @nextWord()

    request
      uri: "https://www.kimonolabs.com/api/4ig21rzm",
      qs:
        apikey: process.env.KIMONO_API_KEY
        q: word

    , (error, response, body) ->
      repos = JSON.parse(body).results.collection1.map (e) ->
        owner: e.repo.text.split('/')[0]
        name: e.repo.text.split('/')[1]
        matched: word
        status: "unqueued"
        file: e.filename.href

      # TODO: put into database

      callback(repos)

  pageNumber: -> if @counter? then @counter / terms.length else 0

  nextWord: ->
    @counter ?= 0
    terms[@counter++ % terms.length]

# console.log process.env.KIMONO_API_KEY
GitHub.loadNextWords (body) -> console.log JSON.parse(body).name
