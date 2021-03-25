class RemoveCustomerIdBuildings < ActiveRecord::Migration[5.2]
  def self.up
    remove_column :buildings, :customer_id, :integer
  end
  def self.down 
    add_column :buildings, :customer_id, :integer
  end
end
