module Currencylayer
  class RatingQuotes
    def initialize(source, update_rates, published_at, target_currencies)
      @source = source
      @update_rates = update_rates
      @published_at = published_at
      @target_currencies = target_currencies
    end

    def upsert
      target_rates = @update_rates.select { |entry| relevant_country?(entry) }

      entry = Currency.find_or_initialize_by(source: @source,
                                             published_at: @published_at)
      entry.target_rates = target_rates
      entry.save
    end

    private

    def relevant_country?(entry)
      @target_currencies.include?(entry.fetch('target'))
    end
  end
end
