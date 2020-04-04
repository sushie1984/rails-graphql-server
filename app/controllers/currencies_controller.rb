class CurrenciesController < ApplicationController
  def index
    @currency = Currency.order(published_at: :asc).last
  end

  def show
    @currency = currency
  end

  private

  def currency
    @currency ||= Currency.find(params[:id])
  end
end
