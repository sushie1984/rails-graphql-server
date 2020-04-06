# frozen_string_literal: true

FactoryBot.create_list(:department, 100, :with_employees, employee_count: 10)

to = Date.today
from = to - 100.days
(from..to).each do |date|
  attributes = FactoryBot.attributes_for(:currency,
                                         :with_random_target_rates,
                                         published_at: date)
  Currency.find_or_create_by(base: attributes[:base],
                             published_at: attributes[:published_at]) do |entry|
    entry.foreign_rates = attributes[:foreign_rates]
  end
end
