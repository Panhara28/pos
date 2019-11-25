class AddImageDataToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :image_data, :text
  end
end
