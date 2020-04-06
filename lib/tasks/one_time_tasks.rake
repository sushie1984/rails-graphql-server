# frozen_string_literal: true

namespace :one_time_tasks do
  desc "Currency data migration for updated schema"
  task currency_data_migration: :environment do
    Currency.where(base: '').find_in_batches do |currencies|
      currencies.each do |currency|
        currency.base = currency.source
        foreign_rates = currency.target_rates.map do |target_rates|
          { 'currency' => target_rates['target'],
            'rate' => target_rates['rate'] }
        end
        currency.foreign_rates = foreign_rates
        currency.save
      end
    end
  end
end
