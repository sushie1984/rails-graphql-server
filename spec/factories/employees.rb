FactoryBot.define do
  factory :employee do
    name { FFaker::Name.name }
    age { Random.rand(16..65) }
    yearly_salary { Random.rand(25_000..100_000.00) }
    work_start { FFaker::Time.date }

    trait :in_department do
      transient do
        department { nil }
      end

      after :create do |employee, evaluator|
        department = evaluator.department || create(:department)
        department.employees << employee
      end
    end
  end
end
