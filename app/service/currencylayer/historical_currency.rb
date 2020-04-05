module Currencylayer
  class HistoricalCurrency
    def initialize(date, currencies)
      @date = date
      @currencies = currencies
    end

    def import!
      currency = client.fetch_history(date: @date, currencies: @currencies)
      source = currency.source
      foreign_rates = Quotes.new(source, currency.quotes).to_foreign_rates
      Currency.upsert_for!(base: source,
                           foreign_rates: foreign_rates,
                           published_at: Date.parse(currency.date))
    end

    private

    def client
      Rails.application.config.currencylayer.client
    end
  end
end
