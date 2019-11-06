class RenameColumnTatalOrder < ActiveRecord::Migration[5.1]
  def change
    rename_column :orders, :tatal, :total
  end
end
