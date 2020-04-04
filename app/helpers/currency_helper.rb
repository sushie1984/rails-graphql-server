module CurrencyHelper
  def available_options(currency)
    [ [currency.source, currency.source] ] |
      currency.target_rates.map { |entry| [ entry['target'], entry['target'] ] }
  end
end
