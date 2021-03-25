class FixFactQuotes < ActiveRecord::Migration[5.2]
  def change
    rename_column :fact_quotes, :QuoteId, :quote_id
    rename_column :fact_quotes, :CreationdDate, :creation_date
    rename_column :fact_quotes, :CompanyName, :company_name
    rename_column :fact_quotes, :Email, :email
    rename_column :fact_quotes, :NbElevators, :nb_elevator
  end
end
