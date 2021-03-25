class CreateColumns < ActiveRecord::Migration[5.2]
  def change
    create_table :columns do |t|

      t.belongs_to :battery, foreign_key: true

      t.integer :batteries_id
      t.string  :type
      t.integer :number_of_floors_served
      t.string  :status
      t.string  :information
      t.string  :notes

      t.timestamps
    end
  end
end
