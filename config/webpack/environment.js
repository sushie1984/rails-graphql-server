const { environment } = require('@rails/webpacker')
const coffee =  require('./loaders/coffee')
var webpack = require('webpack');

environment.loaders.prepend('coffee', coffee)
environment.plugins.prepend('Provide',
  new webpack.ProvidePlugin({
    $: 'jquery/src/jquery',
    jQuery: 'jquery/src/jquery',
    jquery: 'jquery/src/jquery'
  })
)

module.exports = environment
