class AddIsActiveToAdmins < ActiveRecord::Migration[5.1]
  def change
    add_column :admins, :is_active, :boolean, default: true
  end
end
