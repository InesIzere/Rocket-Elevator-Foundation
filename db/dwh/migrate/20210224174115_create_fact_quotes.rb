class CreateFactQuotes < ActiveRecord::Migration[5.2]
  def change
    create_table :fact_quotes do |t|
      t.integer :QuoteId
      t.date :CreationdDate
      t.string :CompanyName
      t.string :Email
      t.integer :NbElevators

      t.timestamps
    end
  end
end
