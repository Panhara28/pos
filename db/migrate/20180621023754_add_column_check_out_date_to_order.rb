class AddColumnCheckOutDateToOrder < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :checkout_date, :date
  end
end
