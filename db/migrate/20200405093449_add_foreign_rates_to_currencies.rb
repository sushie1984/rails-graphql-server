# frozen_string_literal: true

class AddForeignRatesToCurrencies < ActiveRecord::Migration[6.0]
  def change
    add_column :currencies, :foreign_rates, :json, null: false, default: []
  end
end
