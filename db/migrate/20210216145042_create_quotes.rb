class CreateQuotes < ActiveRecord::Migration[5.2]
  def change
    create_table :quotes do |t|
      t.string :building_type
      t.integer :number_of_apartments
      t.integer :number_of_floors
      t.integer :number_of_basements
      t.integer :number_of_companies
      t.integer :number_of_parking_spots
      t.integer :number_of_elevators
      t.integer :number_of_corporations
      t.integer :maximum_occupancy
      t.string :product_line
      t.integer :doors_per_floor
      t.integer :columns_required
      t.integer :elevators_required
      t.integer :total_occupants
      t.integer :elevators_per_occupancy
      t.integer :elevators_per_column
      t.integer :elevator_amount
      t.string :elevator_unit_price
      t.string :elevator_total_price
      t.string :elevator_installation_fees
      t.string :final_price
      t.timestamps
    end
  end
end
