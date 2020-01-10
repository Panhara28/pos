class CreateCashDrawers < ActiveRecord::Migration[5.1]
  def change
    create_table :cash_drawers do |t|
      t.date :cash_drawer_date
      t.decimal :cash_drawer_amout
      t.time :start_at
      t.time :end_at
      t.string :status, default: "assign"
      t.decimal :total_sale_amount
      t.integer :admin_id
      t.integer :user_id

      t.timestamps
    end
  end
end
