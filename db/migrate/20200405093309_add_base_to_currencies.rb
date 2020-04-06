# frozen_string_literal: true

class AddBaseToCurrencies < ActiveRecord::Migration[6.0]
  def change
    add_column :currencies, :base, :string, null: false, default: ''
  end
end
