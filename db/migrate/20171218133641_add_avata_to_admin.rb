class AddAvataToAdmin < ActiveRecord::Migration[5.1]
  def change
    add_column :admins, :avata, :string
  end
end
