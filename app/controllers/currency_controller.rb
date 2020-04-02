class CurrencyController < ApplicationController
  def index
    @query = <<-QUERY
      query currencies($publishedAtFrom: ISO8601DateTime,
                       $publishedAtTo: ISO8601DateTime) {
        currencies(publishedAtFrom: $publishedAtFrom,
                   publishedAtTo: $publishedAtTo) {
                     source publishedAt targetRates { currency rate }
                   }
        }
    QUERY
  end
end
