# frozen_string_literal: true

FactoryBot.define do
  factory :department do
    name { FFaker::Company.bs }
    location { FFaker::Address.secondary_address }

    trait :with_employees do
      transient do
        employee_count { 1 }

        after :create do |department, evaluator|
          department.employees =
            create_list(:employee, evaluator.employee_count)
        end
      end
    end
  end
end
