class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :product_no
      t.string :product_name
      t.string :barcode
      t.text :description
      t.decimal :product_price, precision: 12, scale: 3
      t.decimal :sale_tax, precision: 12, scale: 3
      t.string :photo
      t.boolean :active
      t.references :admin, foreign_key: true

      t.timestamps
    end
  end
end
