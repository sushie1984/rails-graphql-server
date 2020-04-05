require 'money/bank/currencylayer_bank'

bank = Money::Bank::CurrencylayerBank.new
bank.access_key = Rails.application.config.currencylayer.access_key
bank.cache = Rails.application.config.currencylayer.cache
bank.source = Rails.application.config.currencylayer.source
Money.default_bank = bank

require 'currencylayer/client'

base_uri = Rails.application.config.currencylayer.base_uri
access_key = Rails.application.config.currencylayer.access_key
source = Rails.application.config.currencylayer.source

Rails.application.config.currencylayer.client =
  Currencylayer::Client.new(base_uri, access_key, source)
