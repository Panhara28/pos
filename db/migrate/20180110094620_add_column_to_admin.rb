class AddColumnToAdmin < ActiveRecord::Migration[5.1]
  def change
    add_column :admins, :pin, :integer
    add_column :admins, :is_pin_required, :boolean
  end
end
