class Appointment < ApplicationRecord
  belongs_to :hospital
  belongs_to :doctor
  belongs_to :patient_information

  # Standard validations using `validates`
  validates :appointment_date, presence: true
  validates :appointment_time, presence: true

  # Custom validations using `validate`
  validate :appointment_conflict
  validate :date_cannot_be_in_the_past

  # Method to check appointment conflict for the same doctor at the same time
  def appointment_conflict
    overlapping_appointments = Appointment.where(doctor_id: doctor_id)
                                          .where.not(id: id) # Exclude the current record in case of update
                                          .where(appointment_date: appointment_date)
                                          .where(appointment_time: appointment_time)
    if overlapping_appointments.exists?
      errors.add(:appointment_date, "Doctor is already booked at this time.")
    end
  end

  # Method to ensure appointment date is not in the past
  def date_cannot_be_in_the_past
    if appointment_date.present? && appointment_date < Time.now
      errors.add(:appointment_date, "can't be in the past")
    end
  end
end
