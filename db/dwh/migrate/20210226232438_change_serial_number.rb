class ChangeSerialNumber < ActiveRecord::Migration[5.2]
  def change
    change_column :fact_elevators, :serial_number, :string
  end
end
