class CreatePatientInformations < ActiveRecord::Migration[7.0]
  def change
    create_table :patient_informations do |t|
      t.string :aadhar_number
      t.string :patient_name
      t.string :patient_guardian_name
      t.string :patient_address
      t.string :patient_mobile_number
      t.string :blood_group
      t.string :doctor_name
      t.string :hospital
      t.string :clinic_name
      t.string :disease_name
      t.date :date_of_examine
      t.date :date_of_admission
      t.date :date_of_discharge
      t.integer :patient_age
      t.string :patient_gender

      t.timestamps
    end
  end
end
