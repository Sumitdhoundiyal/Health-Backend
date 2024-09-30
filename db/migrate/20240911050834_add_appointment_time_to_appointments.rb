class AddAppointmentTimeToAppointments < ActiveRecord::Migration[7.0]
  def change
    add_column :appointments, :appointment_time, :time
  end
end
