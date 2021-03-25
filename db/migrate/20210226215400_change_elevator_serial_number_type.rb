class ChangeElevatorSerialNumberType < ActiveRecord::Migration[5.2]
  def change
    change_column :elevators, :serial_number, :string
  end
end
