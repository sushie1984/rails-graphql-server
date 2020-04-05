FactoryBot.define do
  factory :currency do
    published_at { DateTime.current }
    base { 'EUR' }
    foreign_rates {
      [{ 'currency' => 'USD', 'rate' => 1.0977 },
       { 'currency' => 'CHF', 'rate' => 1.0581 }]
     }

    trait :for_usd_dollar do
      base { 'USD' }
      foreign_rates {
        [{ 'currency' => 'EUR', 'rate' => 0.895375 },
         { 'currency' => 'CHF', 'rate' => 0.951265 }]
       }
    end

    trait :with_random_target_rates do
      foreign_rates {
        [{ 'currency' => 'USD', 'rate' => Random.rand(1.0..1.2) },
         { 'currency' => 'CHF', 'rate' => Random.rand(1.2..1.4) }]
       }
    end
  end
end
