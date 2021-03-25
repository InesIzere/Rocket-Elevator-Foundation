class RemoveBuildingIdFromBuildingDetails < ActiveRecord::Migration[5.2]
  def self.up
    remove_column :building_details, :building_id, :integer
  end
  def self.down 
    add_column :building_details, :building_id, :integer
  end
end
