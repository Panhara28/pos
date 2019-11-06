class AddColumnPhotoToCustomer < ActiveRecord::Migration[5.1]
  def change
    add_column :customers, :photo, :string
  end
end
