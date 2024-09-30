class AddPatientInformationIdToAppointments < ActiveRecord::Migration[7.0]
  def change
    add_column :appointments, :patient_information_id, :integer
  end
end
