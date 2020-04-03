FactoryBot.define do
  factory :currency do
    published_at { DateTime.current }
    source { 'EUR' }
    target_rates { [{ 'target' => 'USD', 'rate' => 1.0977 },
                    { 'target' => 'CHF', 'rate' => 1.0581 }] }

    trait :for_usd_dollar do
      source { 'USD' }
      target_rates { [{ 'target' => 'EUR', 'rate' => 0.895375 },
                      { 'target' => 'CHF', 'rate' => 0.951265 }] }
    end

    trait :with_random_target_rates do
      target_rates { [{ 'target' => 'USD', 'rate' => Random.rand(1.0..1.2) },
                      { 'target' => 'CHF', 'rate' => Random.rand(1.2..1.4) }] }
    end
  end
end
