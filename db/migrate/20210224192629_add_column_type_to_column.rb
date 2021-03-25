class AddColumnTypeToColumn < ActiveRecord::Migration[5.2]
  def change
    add_column :columns , :column_type, :string 
  end
end
