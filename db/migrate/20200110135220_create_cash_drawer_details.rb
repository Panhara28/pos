class CreateCashDrawerDetails < ActiveRecord::Migration[5.1]
  def change
    create_table :cash_drawer_details do |t|
      t.integer :admin_id
      t.integer :user_id
      t.string :status
      t.integer :cash_drawer_id

      t.timestamps
    end
  end
end
