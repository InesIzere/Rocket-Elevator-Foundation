class RemoveElevatorsPerOccupacyFromQuotes < ActiveRecord::Migration[5.2]
  def self.up
    remove_column :quotes, :elevators_per_column, :integer
  end
  def self.down
    add_column :quotes, :elevators_per_column, :integer
  end
end
