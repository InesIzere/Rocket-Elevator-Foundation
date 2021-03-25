class RemoveColumnsRequired < ActiveRecord::Migration[5.2]
  def self.up
    remove_column :quotes, :columns_required, :integer
  end
  def self.down 
    add_column :quotes, :columns_required, :integer
  end
end
