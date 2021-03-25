class RemoveUserIdFromCustomers < ActiveRecord::Migration[5.2]
  def self.up
    remove_column :customers, :user_id, :integer
  end
  def self.down 
    add_column :customers, :user_id, :integer
  end
end
