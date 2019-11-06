class AddColumnWaittingNoToOrder < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :waitting_no, :integer
  end
end
