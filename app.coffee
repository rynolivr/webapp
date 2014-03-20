require 'coffee-script'

passport = require './passport'

require('zappajs') ->
  @use 'logger'
  @use 'cookieParser'
  @use 'bodyParser'
  @use 'methodOverride'
  @use session: secret: process.env.EC_SECRET
  @use passport.initialize
  @use passport.session
  @use require './github'

  @get '/': "hello"
