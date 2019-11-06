class RenameUserAvataColumnName < ActiveRecord::Migration[5.1]
  def change
    rename_column :users, :avata, :photo
  end
end
