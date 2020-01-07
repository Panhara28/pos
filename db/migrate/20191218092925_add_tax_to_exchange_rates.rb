class AddTaxToExchangeRates < ActiveRecord::Migration[5.1]
  def change
    add_column :exchange_rates, :tax, :decimal, precision: 12, scale: 3
  end
end
