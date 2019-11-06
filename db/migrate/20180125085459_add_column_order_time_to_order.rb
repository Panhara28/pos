class AddColumnOrderTimeToOrder < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :order_time, :time
  end
end
