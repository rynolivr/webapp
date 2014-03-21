controller = (name) -> require "../controllers/#{name}"

module.exports = ->

  # authentication
  @get '/login': controller('sessions').new
  @get '/auth/github': @passport.authenticate('github')
  @get '/auth/github/callback',
    @passport.authenticate('github', failureRedirect: '/login'),
    (req, res) -> res.redirect '/'
