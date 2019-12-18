class AddImageDataToAdmins < ActiveRecord::Migration[5.1]
  def change
    add_column :admins, :image_data, :string
  end
end
