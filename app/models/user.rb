class User < ApplicationRecord
  has_secure_password
  has_many :patients, class_name: 'PatientInformation'
end
