class Api::V1::Admin::DoctorController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_doctor, only: [:update , :destroy, :show]

  def index
    @doctors= ::Doctor.all
    render json: @doctors, status: :ok
  end

  def new
    @doctor = Doctor.new
  end

  def show
    render json: @doctor , status: :ok
  end
  def create
    @doctor = Doctor.new(doctor_information_params)
    if @doctor.save
      render json: @doctor, status: :ok
    else
      render json: { message: "Failed to create doctor" }, status: :unprocessable_entity
    end
  end

  def update

    if @doctor.update(doctor_information_params)
      render json: @doctor, status: :ok
    else
      render json: { message: "Information not updated" }, status: :unprocessable_entity
    end
  end

  def destroy
    if @doctor.destroy
      render json: { message: "Doctor deleted" }, status: :ok
    else
      render json: @doctor ,status: :unprocessable_entity
    end

  end
end

private

    def set_doctor
      @doctor = Doctor.find(params[:id])
    end

    def doctor_information_params
      params.require(:doctor).permit(:first_name,:last_name, :specialization, :email, :contact_number)

    end
