# frozen_string_literal: true

class RemoveSourceFromCurrencies < ActiveRecord::Migration[6.0]
  def change
    remove_column :currencies, :source, :string
  end
end
