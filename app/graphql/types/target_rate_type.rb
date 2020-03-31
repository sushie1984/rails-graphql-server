module Types
  class TargetRateType < Types::BaseObject
    field :currency, String, 'The currency label', null: false, method: :target
    field :rate, Float, 'The current rate for the currency', null: false
  end
end
