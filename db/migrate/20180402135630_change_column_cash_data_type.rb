class ChangeColumnCashDataType < ActiveRecord::Migration[5.1]
  def change
    change_column :orders, :cash, :decimal, precision: 12, scale: 3
  end
end
