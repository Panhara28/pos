class CreateExchangeRates < ActiveRecord::Migration[5.1]
  def change
    create_table :exchange_rates do |t|
      t.integer :usd_amount
      t.float :riel_amount

      t.timestamps
    end
  end
end
