module Currencylayer
  class TargetRatesPresenter
    def initialize(currencylayer_rates)
      @currencylayer_rates = currencylayer_rates
    end

    def restructure
      @restructure ||= begin
        @currencylayer_rates.each_with_object([]) do |(target, rate), entries|
          sanitized_target = target.sub(Money.default_bank.source, '')
          entries << { 'target' => sanitized_target, 'rate' => rate }
        end
      end
    end
  end
end
