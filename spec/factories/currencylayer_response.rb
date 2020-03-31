FactoryBot.define do
  factory :currencylayer_response, class: Hash do
    quotes { { "USDEUR" => 0.895375, "USDCHF" => 0.951265 } }
    source { 'USD' }

    initialize_with { attributes }
  end
end
