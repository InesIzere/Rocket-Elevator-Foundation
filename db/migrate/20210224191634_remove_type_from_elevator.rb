class RemoveTypeFromElevator < ActiveRecord::Migration[5.2]
  def change
    remove_column :elevators, :type
  end
end
