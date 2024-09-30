class Hospital < ApplicationRecord
  has_many :appointments
  has_many :doctors, through: :appointments
  has_many :patient_informations, through: :appointments


end
