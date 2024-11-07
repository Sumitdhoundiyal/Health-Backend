class Api::V1::DashboardController < ApplicationController


  def stats
    total_patients = PatientInformation.count
    total_doctors = Doctor.count
    total_appointments = Appointment.count
    total_hospitals =Hospital.count
    # notifications = Notification.count # Assuming you have a Notification model
    total_balance = Payment.sum(:amount)

    render json: {
      totalPatients: total_patients,
      totalDoctors: total_doctors,
      totalAppointments: total_appointments,
      totalHospitals: total_hospitals,
      # notifications: notifications,
      balance: "#{total_balance} GO" # Assuming GO is the currency used
    }
  end
end
