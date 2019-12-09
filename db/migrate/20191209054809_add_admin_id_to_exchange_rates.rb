class AddAdminIdToExchangeRates < ActiveRecord::Migration[5.1]
  def change
    add_column :exchange_rates, :admin_id, :integer
  end
end
