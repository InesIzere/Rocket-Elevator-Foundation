class RemoveEmployeeIdFromBatteries < ActiveRecord::Migration[5.2]
  def self.up
    remove_column :batteries, :employee_id, :integer
  end
  def self.down 
    add_column :batteries, :employee_id, :integer
  end
end
