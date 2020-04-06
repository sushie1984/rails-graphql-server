module CurrencyHelper
  def available_options(currency)
    [[currency.base, currency.base]] | currency.foreign_rates.map do |entry|
      [entry['currency'], entry['currency']]
    end
  end
end
