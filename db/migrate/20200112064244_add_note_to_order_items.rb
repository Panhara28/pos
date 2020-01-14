class AddNoteToOrderItems < ActiveRecord::Migration[5.1]
  def change
    add_column :order_items, :note, :string
  end
end
