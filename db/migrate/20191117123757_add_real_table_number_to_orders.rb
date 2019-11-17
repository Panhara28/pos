class AddRealTableNumberToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :real_table_number, :string
  end
end
