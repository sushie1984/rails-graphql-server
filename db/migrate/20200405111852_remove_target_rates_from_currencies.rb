class RemoveTargetRatesFromCurrencies < ActiveRecord::Migration[6.0]
  def change
    remove_column :currencies, :target_rates, :json
  end
end
