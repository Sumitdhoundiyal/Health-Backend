class UpdateAppointmentsPatientReference < ActiveRecord::Migration[7.0]
  def change
    # Remove the old foreign key and patient_id column
    remove_foreign_key :appointments, :patients rescue nil
    remove_column :appointments, :patient_id, if_exists: true

    # Remove the existing patient_information_id column (if it already exists)
    remove_column :appointments, :patient_information_id, if_exists: true

    # Re-add the correct patient_information_id reference with foreign key
    add_reference :appointments, :patient_information, null: false, foreign_key: true
  end
end
