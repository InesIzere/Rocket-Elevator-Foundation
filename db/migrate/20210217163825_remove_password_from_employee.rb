class RemovePasswordFromEmployee < ActiveRecord::Migration[5.2]
  def change
    remove_column :employees, :password, :string
  end
end
