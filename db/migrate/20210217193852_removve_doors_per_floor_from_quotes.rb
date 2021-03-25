class RemovveDoorsPerFloorFromQuotes < ActiveRecord::Migration[5.2]
  def self.up
    remove_column :quotes, :doors_per_floor, :integer
  end
  def self.down 
    add_column :quotes, :doors_per_floor, :integer
  end
end
