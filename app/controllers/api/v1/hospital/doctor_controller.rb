class Api::V1::Hospital::DoctorController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_hospital
  before_action :set_doctor, only: [:show, :update, :destroy]

  # List all doctors associated with the current hospital
  def index
    @doctor = @hospital.doctors
    render json: @doctor
  end

  # Show a specific doctor record
  def show
    if @doctor.hospital == @hospital
      render json: @doctor, status: :ok
    else
      render json: { error: 'Not Authorized' }, status: :forbidden
    end
  end

  # Create a new doctor record
  def create
    @doctor = @hospital.doctors.new(doctor_information_params)

    if @doctor.save
      render json: @doctor, status: :created
    else
      render json: { message: 'Failed to create doctor', errors: @doctor.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # Update a specific doctor record
  def update
    if @doctor.hospital == @hospital && @doctor.update(doctor_information_params)
      render json: @doctor, status: :ok
    else
      render json: { message: 'Failed to update doctor', errors: @doctor.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # Delete a specific doctor record
  def destroy
    if @doctor.hospital == @hospital && @doctor.destroy
      render json: { message: 'Doctor deleted successfully' }, status: :ok
    else
      render json: { message: 'Failed to delete doctor', errors: @doctor.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  # Set the current hospital based on hospital_id
  def set_hospital
    @hospital = Hospital.find(params[:id])
  end

  # Set the doctor record for actions that need it
  def set_doctor
    @doctor = @hospital.doctors.find(params[:id])
  end

  # Permit only the allowed parameters for doctor information
  def doctor_information_params
    params.require(:doctor).permit(:first_name, :last_name, :specialization, :email, :contact_number)
  end
end
