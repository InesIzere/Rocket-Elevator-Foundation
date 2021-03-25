class RemoveTotalOccupantsFromQuotes < ActiveRecord::Migration[5.2]
  def self.up
    remove_column :quotes, :total_occupants, :integer
  end
  def self.down
    add_column :quotes, :total_occupants, :integer
  end
end
