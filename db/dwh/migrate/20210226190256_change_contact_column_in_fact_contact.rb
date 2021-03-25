class ChangeContactColumnInFactContact < ActiveRecord::Migration[5.2]
  def change
    rename_column :fact_contacts, :conctact_id, :contact_id
  end
end
