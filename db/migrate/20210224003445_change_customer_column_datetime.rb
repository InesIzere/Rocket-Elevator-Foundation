class ChangeCustomerColumnDatetime < ActiveRecord::Migration[5.2]
  def change
    change_column :customers, :created_at, :date
  end
end
