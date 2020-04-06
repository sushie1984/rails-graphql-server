# frozen_string_literal: true

module Types
  class ForeignRateType < Types::BaseObject
    field :currency, String, 'The currency label', null: false
    field :rate, Float, 'The current rate for the currency', null: false
  end
end
