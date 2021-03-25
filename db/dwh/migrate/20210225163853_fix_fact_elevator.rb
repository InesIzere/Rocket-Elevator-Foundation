class FixFactElevator < ActiveRecord::Migration[5.2]
  def change
    rename_column :fact_elevators, :SerialNumber, :serial_number
    rename_column :fact_elevators, :DateOfCommissioning, :date_of_commissioning
    rename_column :fact_elevators, :BuildingId, :building_id
    rename_column :fact_elevators, :CustomerId, :customer_id
    rename_column :fact_elevators, :BuildingCity, :building_city
  end
end
