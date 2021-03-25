class ChangeLeadTimeType < ActiveRecord::Migration[5.2]
  def change
    change_column :leads, :contact_request_date, :datetime, null: false, default: -> {'CURRENT_TIMESTAMP'}
  end
end
