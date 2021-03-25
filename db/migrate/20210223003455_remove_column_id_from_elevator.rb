class RemoveColumnIdFromElevator < ActiveRecord::Migration[5.2]
  def self.up
    remove_column :elevators, :column_id, :integer
  end
  def self.down 
    add_column :elevators, :column_id, :integer
  end
end
