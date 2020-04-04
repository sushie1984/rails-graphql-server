class CurrenciesController < ApplicationController
  def index
    @currency = Currency.order(published_at: :asc).last
  end
end
