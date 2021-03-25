class CreateElevators < ActiveRecord::Migration[5.2]
  def change
    create_table :elevators do |t|
      t.integer "column_id", null: false
      t.integer "serial_number", null: false
      t.string "model", null: false
      t.string "type", null: false
      t.string "status", null: false
      t.datetime "date_of_commissioning", null: false
      t.datetime "date_of_last_inspection", null: false
      t.integer "certificate_of_inspection", null: false
      t.string "information", null: false
      t.string "notes"
    end
  end
end
