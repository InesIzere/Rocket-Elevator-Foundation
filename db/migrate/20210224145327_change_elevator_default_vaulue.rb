class ChangeElevatorDefaultVaulue < ActiveRecord::Migration[5.2]
  def change
    change_column :elevators, :serial_number, :integer
    change_column :elevators, :model, :string
    change_column :elevators, :type, :string
    change_column :elevators, :status, :string
    change_column :elevators, :date_of_commissioning, :date
    change_column :elevators, :date_of_last_inspection, :date
    change_column :elevators, :certificate_of_inspection, :integer
    change_column :elevators, :information, :string
    change_column :elevators, :notes, :string
  end
end
