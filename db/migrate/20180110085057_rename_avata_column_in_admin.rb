class RenameAvataColumnInAdmin < ActiveRecord::Migration[5.1]
  def change
    rename_column :admins, :avata, :photo
  end
end
