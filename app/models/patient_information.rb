class PatientInformation < ApplicationRecord
  # belongs_to :hospital , optional: true
  # belongs_to :doctor , optional:true
  belongs_to :user
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP, message: "must be a valid email address" }
  has_many :payments

  def total_payments
    payments.sum(:amount)
  end
end
