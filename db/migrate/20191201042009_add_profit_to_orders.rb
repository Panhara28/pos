class AddProfitToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :profit, :decimal, precision: 12, scale: 3
  end
end
