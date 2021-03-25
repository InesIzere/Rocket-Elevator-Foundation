class RemoveTypeFromColumn < ActiveRecord::Migration[5.2]
  def change
    remove_column :columns, :type
  end
end
