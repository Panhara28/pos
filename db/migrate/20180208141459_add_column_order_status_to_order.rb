class AddColumnOrderStatusToOrder < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :order_status, :string, default: "pending"
  end
end
