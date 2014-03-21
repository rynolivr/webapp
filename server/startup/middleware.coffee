module.exports = ->
  @use 'logger'
  @use 'cookieParser'
  @use 'bodyParser'
  @use 'methodOverride'
  @use session: secret: process.env.SESSION_SECRET
  @use @passport.initialize()
  @use @passport.session()
  @use @app.router
