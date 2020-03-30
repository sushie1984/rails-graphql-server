require 'money/bank/currencylayer_bank'

bank = Money::Bank::CurrencylayerBank.new
bank.access_key = Rails.application.config.currencylayer.access_key
bank.cache = Rails.application.config.currencylayer.cache
bank.source = Rails.application.config.currencylayer.source
Money.default_bank = bank
