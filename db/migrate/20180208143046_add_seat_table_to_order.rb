class AddSeatTableToOrder < ActiveRecord::Migration[5.1]
  def change
    add_reference :orders, :seat_table, foreign_key: true
  end
end
