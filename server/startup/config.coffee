module.exports = ->

  @set # use handlebars templating
    'view engine': 'hbs'
    'views': require('fs').realpathSync("#{__dirname}/../../views")
