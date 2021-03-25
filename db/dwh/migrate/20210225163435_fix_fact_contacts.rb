class FixFactContacts < ActiveRecord::Migration[5.2]
  def change
    rename_column :fact_contacts, :ContactId, :conctact_id
    rename_column :fact_contacts, :CreationDate, :creation_date
    rename_column :fact_contacts, :CompanyName, :company_name
    rename_column :fact_contacts, :Email, :email
    rename_column :fact_contacts, :ProjectName, :project_name
  end
end
