class CreateJoinTableUserPermission < ActiveRecord::Migration[5.1]
  def change
    create_join_table :users, :permissions do |t|
      t.index [:user_id, :permission_id]
      # t.index [:permission_id, :user_id]
    end
  end
end
