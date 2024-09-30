class RemoveSomethingToPatientInformations < ActiveRecord::Migration[7.0]
  def change
    remove_column :patient_informations, :hospital_id
    remove_column :patient_informations, :hospital
    remove_column :patient_informations, :doctor_name
    remove_column :patient_informations, :disease_name

    add_column :patient_informations, :email, :string


  end
end
