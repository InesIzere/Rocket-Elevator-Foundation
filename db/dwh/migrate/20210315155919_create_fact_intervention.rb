class CreateFactIntervention < ActiveRecord::Migration[5.2]
  def change
    create_table :fact_interventions do |t|
      t.integer :employee_id, null: false
      t.integer :building_id, null: false
      t.integer :battery_id
      t.integer :column_id
      t.integer :elevator_id
      t.datetime :start_of_intervention, null: false
      t.datetime :end_of_intervention
      t.string :result, null: false
      t.string :report
      t.string :status, null: false
    end
  end
end
