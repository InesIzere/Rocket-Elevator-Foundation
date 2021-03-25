class FixDimCustomers < ActiveRecord::Migration[5.2]
  def change
    rename_column :dim_customers, :CreationDate, :creation_date
    rename_column :dim_customers, :CompanyName, :company_name
    rename_column :dim_customers, :FullNameCompanyContact, :full_name_company_contact
    rename_column :dim_customers, :EmailCompanyContact, :email_company_conctact
    rename_column :dim_customers, :NbElevator, :nb_elevator
    rename_column :dim_customers, :CustomerCity, :customer_city
  end
end
