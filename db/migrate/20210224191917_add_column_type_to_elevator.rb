class AddColumnTypeToElevator < ActiveRecord::Migration[5.2]
  def change
    add_column :elevators, :elevator_type, :string
  end
end
