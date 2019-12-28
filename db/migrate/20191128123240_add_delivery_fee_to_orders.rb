class AddDeliveryFeeToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :delivery_fee, :decimal, precision: 12, scale: 3, default: 0.0
  end
end
