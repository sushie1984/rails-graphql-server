namespace :currencylayer_import do
  desc "Daily import of most accurate currency"
  task daily: :environment do
    today = Date.today
    currencies = Rails.application.config.currencylayer.currencies
    Currency::HistoricalCurrency.new(today, currencies).import
  end
end
