class CreateDimCustomers < ActiveRecord::Migration[5.2]
  def change
    create_table :dim_customers do |t|
      t.date :CreationDate
      t.string :CompanyName
      t.string :FullNameCompanyContact
      t.string :EmailCompanyContact
      t.integer :NbElevator
      t.string :CustomerCity

      t.timestamps
    end
  end
end
