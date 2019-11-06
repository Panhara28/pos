class AddColumnDiscountToOrderItem < ActiveRecord::Migration[5.1]
  def change
    add_column :order_items, :discount, :decimal, precision: 12, scale: 3, default: 0.0
  end
end
