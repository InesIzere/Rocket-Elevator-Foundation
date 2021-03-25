class RemoveBatteriesIdFromColumn < ActiveRecord::Migration[5.2]
  def self.up
    remove_column :columns, :batteries_id, :integer
  end
  def self.down 
    add_column :columns, :batteries_id, :integer
  end
end
