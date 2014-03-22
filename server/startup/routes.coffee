module.exports = ->

  # helper functions
  controller = (name) -> require "../controllers/#{name}"
  authenticated = @passport.authenticate('github', failureRedirect: '/login')

  # listing repositories
  @get '/', controller('repos').list
  @get '/ajax/repos/next': controller('repos').next
  @get '/ajax/repos/count': controller('repos').count
  @post '/ajax/repos/fix': controller('repos').fix

  # authentication
  @get '/login': controller('sessions').new
  @get '/auth/github': @passport.authenticate('github')
  @get '/auth/github/callback', authenticated, (req, res) -> res.redirect '/'
