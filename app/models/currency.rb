class Currency < ApplicationRecord
  def self.upsert_for!(base:, foreign_rates:, published_at:)
    entry = where(published_at:
                    (published_at.beginning_of_day..published_at.end_of_day))
            .first_or_initialize(base: base)
    entry.foreign_rates = foreign_rates
    entry.published_at = published_at
    entry.save!
    entry
  end
end
