class AddHospitalIdToPatientInformations < ActiveRecord::Migration[7.0]
  def change
    add_column :patient_informations, :hospital_id, :integer
  end
end
