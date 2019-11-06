class AddColumnCashToOrder < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :cash, :integer, default: 0
  end
end
