class AddColumnAdminToSeatTables < ActiveRecord::Migration[5.1]
  def change
    add_reference :seat_tables, :admin, foreign_key: true
  end
end
