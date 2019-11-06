class CreateSeatTables < ActiveRecord::Migration[5.1]
  def change
    create_table :seat_tables do |t|
      t.string :table_number
      t.string :description

      t.timestamps
    end
  end
end
