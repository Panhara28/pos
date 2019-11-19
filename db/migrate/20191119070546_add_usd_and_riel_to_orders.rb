class AddUsdAndRielToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :usd, :decimal
    add_column :orders, :riel, :decimal
  end
end
