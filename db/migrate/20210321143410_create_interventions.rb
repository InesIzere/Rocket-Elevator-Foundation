class CreateInterventions < ActiveRecord::Migration[5.2]
  def change
    create_table :interventions do |t|
      t.bigint :author_id, null: false
      t.references :customer, foreign_key: true, null: false
      t.references :building, foreign_key: true, null: false
      t.references :battery, foreign_key: true
      t.references :column, foreign_key: true
      t.references :elevator, foreign_key: true
      t.references :employee, foreign_key: true
      t.date :start_date
      t.date :end_date
      t.string :result, default: "Incomplete"
      t.string :report
      t.string :status, default: "Pending"

      t.timestamps
    end
  end
end
