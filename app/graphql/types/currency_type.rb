# frozen_string_literal: true

module Types
  class CurrencyType < Types::BaseObject
    field :id, ID, 'The unique id of the currency entry', null: false
    field :base,
          String,
          'The base currency that this entry relates to',
          null: false
    field :foreignRates,
          [ForeignRateType, null: true],
          'A list containing foreign rates for base currency',
          null: true,
          method: :foreign_rates
    field :publishedAt,
          GraphQL::Types::ISO8601DateTime,
          'The iso8601 datetime the targetRates for the base currency '\
          'belongs to',
          null: false,
          method: :published_at

    delegate :target_rates, to: :object
  end
end
