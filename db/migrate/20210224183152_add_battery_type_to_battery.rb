class AddBatteryTypeToBattery < ActiveRecord::Migration[5.2]
  def change
    add_column :batteries, :battery_type, :string
  end
end
