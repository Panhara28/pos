class AddOriginalPriceToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :original_price, :decimal, precision: 12, scale: 3
  end
end
