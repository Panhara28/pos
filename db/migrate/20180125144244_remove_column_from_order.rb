class RemoveColumnFromOrder < ActiveRecord::Migration[5.1]
  def change
    remove_column :orders, :tax, :string
    remove_column :orders, :shipping, :string
  end
end
