class AddCustomerIdToCustomers < ActiveRecord::Migration[5.1]
  def change
    add_column :customers, :admin_id, :integer
  end
end
