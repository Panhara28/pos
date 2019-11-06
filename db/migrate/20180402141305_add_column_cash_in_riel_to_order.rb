class AddColumnCashInRielToOrder < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :cash_in_riel, :decimal, precision: 12, scale: 3, default: 0.0
    add_column :orders, :total_cash_in_riel, :decimal, precision: 12, scale: 3, default: 0.0
  end
end
