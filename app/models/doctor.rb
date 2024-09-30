class Doctor < ApplicationRecord

  has_many :appointments
  has_many :patients_informations, through: :appointments
  has_many :available_time_slots # custom model for availability

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :specialization, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP, message: "must be a valid email address" }
  validates :contact_number, length: { is: 10 }, allow_blank: false

  def available?(date_time)
    available_time_slots.where(start_time: date_time.beginning_of_hour..date_time.end_of_hour).exists?
  end

end
