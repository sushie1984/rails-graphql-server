class CurrenciesController < ApplicationController
  def index
    @currency = Currency.order(published_at: :asc).last
  end

  def show
    @currency = currency
  end

  def exchange
    @foreign_rate =
      { 'target' => foreign_currency, 'result' => foreign_rate * Float(value) }
    respond_to do |format|
      format.js {}
    end
  end

  private

  def foreign_rate
    CurrencyExchanger.new(base_currency, foreign_rates)
                     .foreign_rate_for(foreign_currency)
  end

  def base_currency
    currency_params[:base]
  end

  def foreign_rates
    currency.target_rates || currency.foreign_rates
  end

  def foreign_currency
    currency_params[:foreign]
  end

  def value
    currency_params[:value]
  end

  def currency
    @currency ||= Currency.find(params[:id])
  end

  def currency_params
    params.require(:currency).permit(:base, :value, :foreign)
  end
end
