class AddTwoColumnToOrder < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :tax, :decimal, precision: 12, scale: 3, :default => 0.0
    add_column :orders, :shipping, :decimal, precision: 12, scale: 3, :default => 0.0
  end
end
