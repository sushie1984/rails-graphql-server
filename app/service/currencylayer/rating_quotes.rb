module Currencylayer
  class RatingQuotes
    def initialize(base, foreign_rates_update, published_at)
      @base = base
      @foreign_rates_update = foreign_rates_update
      @published_at = published_at
    end

    def upsert
      entry =
        Currency.find_or_initialize_by(base: @base, published_at: @published_at)
      entry.foreign_rates = @foreign_rates_update
      entry.save
    end
  end
end
