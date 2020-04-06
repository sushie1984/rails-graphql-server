# frozen_string_literal: true

FactoryBot.define do
  factory :currencylayer_response, class: Hash do
    quotes { { "USDEUR" => 0.895375, "USDCHF" => 0.951265 } }
    source { 'USD' }
    success { true }
    date { Date.today.iso8601 }

    trait :unsuccessfull do
      success { false }
      error { { 'code': 201, 'info': 'Something invalid' } }
    end

    initialize_with { attributes }
  end
end
