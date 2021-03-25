class CreateBuildings < ActiveRecord::Migration[5.2]
  def change
    create_table :buildings do |t|
      t.integer :customer_id
      t.string :address_building
      t.string :full_name_administrator
      t.string :email_administrator
      t.string :phone_administrator
      t.string :full_name_technical_contact_building
      t.string :technical_contact_building_email
      t.string :technical_contact_building_phone     
    end
  end
end
