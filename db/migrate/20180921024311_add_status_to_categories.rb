class AddStatusToCategories < ActiveRecord::Migration[5.1]
  def change
    add_column :categories, :status, :boolean
  end
end
