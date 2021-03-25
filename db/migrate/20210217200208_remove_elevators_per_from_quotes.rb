class RemoveElevatorsPerFromQuotes < ActiveRecord::Migration[5.2]
  def self.up
    remove_column :quotes, :elevators_per_occupancy, :integer
  end
  def self.down
    add_column :quotes, :elevators_per_occupancy, :integer
  end
end
