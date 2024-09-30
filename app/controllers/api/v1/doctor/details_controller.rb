class Api::V1::Doctor::DetailsController < ApplicationController
  skip_before_action :verify_authenticity_token
    def new
      @doctor = Doctor.new(doctor_information)
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
      @doctor = Doctor.find(params[:id])
      if @doctor.update(doctor_information_params)
        render json: @doctor, status: :ok
      else
        render json: { message: "Information not updated" }, status: :unprocessable_entity
      end
    end
end

  private

    def doctor_information_params
      params.require(:doctor).permit(:first_name,:last_name, :specialization, :email, :contact_number)
    end
