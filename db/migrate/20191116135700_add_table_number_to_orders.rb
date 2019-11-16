class AddTableNumberToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :table_number, :string
  end
end
