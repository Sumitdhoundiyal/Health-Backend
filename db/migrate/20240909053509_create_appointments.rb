class CreateAppointments < ActiveRecord::Migration[7.0]
  def change
    create_table :appointments do |t|
      t.references :hospital, null: false, foreign_key: true
      t.references :doctor, null: false, foreign_key: true
      t.references :patient_information, null: false, foreign_key: true
      t.datetime :appointment_date


      t.timestamps
    end
  end
end
