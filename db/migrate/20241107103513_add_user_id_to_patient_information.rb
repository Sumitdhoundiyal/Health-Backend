# db/migrate/20241107103513_add_user_id_to_patient_information.rb
class AddUserIdToPatientInformation < ActiveRecord::Migration[6.1]
  def up
    # Add user_id column without NOT NULL constraint first
    add_reference :patient_informations, :user, foreign_key: true

    # Create a default user or set existing user for backfilling
    default_user = User.first || User.create!(email: 'default@example.com', password: 'password')

    # Update existing records to reference the default user
    PatientInformation.update_all(user_id: default_user.id)

    # Finally, add the NOT NULL constraint
    change_column_null :patient_informations, :user_id, false
  end

  def down
    remove_reference :patient_informations, :user
  end
end
