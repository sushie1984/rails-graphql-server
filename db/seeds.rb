# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


departments =
  FactoryBot.create_list(:department, 100, :with_employees, employee_count: 10)

to = Date.today
from = to - 100.days
(from..to).each do |date|
  attributes = FactoryBot.attributes_for(:currency,
                                         :with_random_target_rates,
                                         published_at: date)
  Currency.find_or_create_by(source: attributes[:source],
                             published_at: attributes[:published_at]) do |entry|
    entry.target_rates = attributes[:target_rates]
  end
end
