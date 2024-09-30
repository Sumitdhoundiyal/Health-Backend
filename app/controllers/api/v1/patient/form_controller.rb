class Api::V1::Patient::FormController < ApplicationController

  skip_before_action :verify_authenticity_token



  def show
        @patient_information = PatientInformation.find(params[:id])
        render json: @patient_information
  end

  def create
    @patient_information = PatientInformation.new(patient_information_params)

    if @patient_information.save
      render json: @patient_information, status: :created, message: 'Patient created successfully'
    else
      render json: @patient_information.errors, status: :unprocessable_entity
    end
  end

  def update
    @patient_information = PatientInformation.find(params[:id])
    if @patient_information.update(patient_information_params)
    render json: @patient_information, status: :ok, message: 'Patient updated successfully'
    else
      render json: @patient_information.errors, status: :unprocessable_entity
    end
  end

  def destroy
        @patient_information = PatientInformation.find(params[:id])
       if @patient_information.destroy
         render json: {message: 'Patient deleted successfully'}, status: :ok
       else
          render json: @patient_information, status: :unprocessable_entity

       end

  end



  private


  def patient_information_params
    params.require(:patient_information).permit(:aadhar_number, :patient_name, :patient_guardian_name, :patient_address,
      :patient_mobile_number, :blood_group,  :patient_age, :patient_gender,:email)
  end
end
