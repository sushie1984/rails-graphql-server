# frozen_string_literal: true

namespace :currencylayer_import do
  desc "Daily import of most accurate currency"
  task daily: :environment do
    today = Date.today
    currencies = Rails.application.config.currencylayer.currencies
    Currencylayer::HistoricalCurrency.new(today, currencies).import!
  end

  desc 'Historical currency import within a FROM= and TO= iso8601 date range'
  task historical: :environment do
    currencies = Rails.application.config.currencylayer.currencies
    from = Date.parse(ENV['FROM']).iso8601
    to = Date.parse(ENV['TO']).iso8601
    (from..to).to_a.each do |date|
      Currencylayer::HistoricalCurrency.new(date, currencies).import!
    end
  end
end
