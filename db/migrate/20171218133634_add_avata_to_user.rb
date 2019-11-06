class AddAvataToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :avata, :string
  end
end
