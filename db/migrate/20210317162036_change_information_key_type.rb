class ChangeInformationKeyType < ActiveRecord::Migration[5.2]
  def change
    change_column :building_details, :information_key, :text
  end
end
