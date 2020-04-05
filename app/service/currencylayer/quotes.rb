module Currencylayer
  class Quotes
    def initialize(source, currencylayer_quotes)
      @currencylayer_quotes = currencylayer_quotes
      @source = source
    end

    def to_foreign_rates
      @to_foreign_rates ||= begin
        @currencylayer_quotes.each_with_object([]) do |(target, rate), entries|
          sanitized_target = target.sub(@source, '')
          entries << { 'currency' => sanitized_target, 'rate' => rate }
        end
      end
    end
  end
end
