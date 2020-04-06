# frozen_string_literal: true

class CreateCurrencies < ActiveRecord::Migration[6.0]
  def change
    create_table :currencies do |t|
      t.datetime :published_at
      t.string :source
      t.json :target_rates

      t.timestamps
    end
  end
end
