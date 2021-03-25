class RemoveNumberOfCorporationsFromQuotes < ActiveRecord::Migration[5.2]
  def self.up
    remove_column :quotes, :number_of_corporations, :integer
  end
  def self.down 
    add_column :quotes, :number_of_corporations, :integer
  end
end
