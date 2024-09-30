class Api::V1::Hospital::PatientController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_hospital
  before_action :set_patient_information, only: [:show, :update, :destroy]

  # List all patient records associated with the current hospital
  def index
    @patient_information = @hospital.patient_informations # Assuming the association is defined
    render json: @patient_information
  end

  # Show a specific patient record
  def show
    if @patient_information.hospital == @hospital
      render json: @patient_information
    else
      render json: { error: 'Not Authorized' }, status: :forbidden
    end
  end

  def create
    @patient_information = @hospital.patient_informations.new(patient_information_params)
    if @patient_information.save
      render json: @patient_information, status: :created
    else
        render json: @patient_information.errors, status: :unprocessable_entity
    end
  end

  # Update a specific patient record
  def update
    if @patient_information.hospital == @hospital && @patient_information.update(patient_information_params)
      render json: { message: 'Patient information was successfully updated' }, status: :ok
    else
      render json: { error: 'Not Authorized or Update failed' }, status: :forbidden
    end
  end

  # Delete a specific patient record
  def destroy
    if @patient_information.hospital == @hospital && @patient_information.destroy
      render json: { message: 'Patient information deleted successfully' }, status: :ok
    else
      render json: { error: 'Not Authorized or Deletion failed' }, status: :forbidden
    end
  end

  def search
    # Example search logic
    query = params[:query]
    @patients = @hospital.patient_informations.where('patient_name LIKE ?', "%#{query}%")
    render json: @patients
  end

  def recent
    start_date = params[:start_date] ? Date.parse(params[:start_date]) : 30.days.ago.to_date
    end_date = params[:end_date] ? Date.parse(params[:end_date]) : Date.today

    @recent_patients = @hospital.patient_informations.where(date_of_admission: start_date..end_date)
    render json: @recent_patients
  end

  private

  # Set the current hospital based on hospital_id
  def set_hospital
     @hospital = Hospital.find(params[:id]) # Adjust this according to how you identify the current hospital
  end

  # Set the patient information record for actions that need it
  def set_patient_information
    @patient_information = PatientInformation.find(params[:id])
  end

  # Permit only the allowed parameters for patient information
  def patient_information_params
    params.require(:patient_information).permit(:aadhar_number, :patient_name, :patient_guardian_name, :patient_address,
      :patient_mobile_number, :blood_group, :doctor_name, :hospital, :clinic_name, :disease_name, :date_of_examine,
      :date_of_admission, :date_of_discharge, :patient_age, :patient_gender)
  end
end
