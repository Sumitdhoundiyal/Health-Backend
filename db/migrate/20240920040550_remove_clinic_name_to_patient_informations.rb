class RemoveClinicNameToPatientInformations < ActiveRecord::Migration[7.0]
  def change
    remove_column :patient_informations, :clinic_name
    remove_column :patient_informations, :date_of_discharge
    remove_column :patient_informations, :date_of_admission
    remove_column :patient_informations, :date_of_examine
  end
end
