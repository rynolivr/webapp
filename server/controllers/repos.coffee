require('../model/repo');

module.exports =
  list: (req, res) -> res.render 'repos/list'
  next: (req, res) ->
    Repo.find(status: 'queued').sort(date: -1).execFind (err, result) ->
      res.send result[0]
