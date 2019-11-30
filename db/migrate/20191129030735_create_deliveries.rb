class CreateDeliveries < ActiveRecord::Migration[5.1]
  def change
    create_table :deliveries do |t|
      t.decimal :delivery_fee
      t.string :company
      t.integer :admin_id
      t.integer :user_id

      t.timestamps
    end
  end
end
