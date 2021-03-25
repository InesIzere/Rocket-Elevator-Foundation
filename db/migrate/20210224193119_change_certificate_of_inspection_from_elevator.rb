class ChangeCertificateOfInspectionFromElevator < ActiveRecord::Migration[5.2]
  def change
    change_column :elevators, :certificate_of_inspection, :string 
  end
end
