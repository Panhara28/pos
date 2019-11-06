class AddColumnsToUserTable < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :pin, :integer
    add_column :users, :is_pin_required, :boolean
  end
end
