# frozen_string_literal: true

module Currencylayer
  class UnsuccessfullQueryError < StandardError; end
  class Client
    include HTTParty

    def initialize(base_uri, access_key, source)
      @base_uri = base_uri
      @access_key = access_key
      @source = source
      self.class.base_uri(@base_uri)
    end

    def fetch_history(date:, currencies:)
      query_params =
        { date: as_iso8601(date), currencies: as_comma_separated(currencies) }
      response = self.class.get('/historical',
                                query: default_query_params.merge(query_params))

      parsed_response = response.parsed_response.with_indifferent_access
      unless parsed_response['success']
        raise UnsuccessfullQueryError, parsed_response['error']
      end

      OpenStruct.new(parsed_response)
    end

    private

    def as_iso8601(date)
      Date.parse(date.to_s).iso8601
    end

    def as_comma_separated(currencies)
      currencies.to_a.join(',')
    end

    def default_query_params
      { access_key: @access_key, source: @source }
    end
  end
end
