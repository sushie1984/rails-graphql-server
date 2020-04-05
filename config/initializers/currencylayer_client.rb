require 'currencylayer/client'

base_uri = Rails.application.config.currencylayer.base_uri
access_key = Rails.application.config.currencylayer.access_key
source = Rails.application.config.currencylayer.source

Rails.application.config.currencylayer.client =
  Currencylayer::Client.new(base_uri, access_key, source)
