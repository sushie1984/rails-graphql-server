class UnknownCurrency < StandardError; end

class CurrencyExchanger
  def initialize(base_currency, foreign_rates)
    @base_currency = base_currency
    @foreign_rates = foreign_rates
  end

  def foreign_rate_for(foreign_currency)
    return 1.0 if @base_currency == foreign_currency
    return foreign_rate(foreign_currency) if foreign_rates?(foreign_currency)

    rate_for(foreign_currency) || inverse_rate || unknown_currency_error!
  end

  private

  def foreign_rate(foreign_currency)
    rate_for(foreign_currency) / rate_for(@base_currency)
  end

  def rate_for(currency)
    (@foreign_rates.find { |entry| entry['currency'] == currency } || {})['rate']
  end

  def inverse_rate
    rate = rate_for(@base_currency)
    return unless rate

    1.0 / rate
  end

  def unknown_currency_error!
    raise UnknownCurrency, 'The foreign_currency has no rate defined!'
  end

  def foreign_rates?(foreign_currency)
    foreign_currencies.include?(foreign_currency) &&
      foreign_currencies.include?(@base_currency)
  end

  def foreign_currencies
    @foreign_currencies ||=
      @foreign_rates.map { |foreign_rate| foreign_rate['currency'] }
  end
end
