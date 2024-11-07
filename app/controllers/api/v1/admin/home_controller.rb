class Api::V1::Admin::HomeController < ApplicationController

  skip_before_action :verify_authenticity_token
  before_action :patient, only: [ :update, :show, :destory]
  before_action :authorized
        def index
          @patient_information=PatientInformation.all
          render json: @patient_information
        end

        def show
          render json: @patient_information
        end

        def update

          if @patient_information.update(patient_information_params)
            render json: { message: "Patient information was successfully updated" }, status: :ok
          else
            render json: @patient_information.errors, status: :unprocessable_entity
          end
        end


        def destroy
          if @patient_information.destroy
           render json:  {message:"Patient information deleted successfully"}, status: :ok
          else
            render json: @patient_information.errors, status: :unprocessable_entity
          end
        end

       private

        def patient
          @patient_information = PatientInformation.find(params[:id])

        end


        def patient_information_params
          params.require(:patient_information).permit(:aadhar_number, :patient_name, :patient_guardian_name, :patient_address,
            :patient_mobile_number, :blood_group, :doctor_name, :hospital, :clinic_name, :disease_name, :date_of_examine,
            :date_of_admission, :date_of_discharge, :patient_age, :patient_gender)
        end

        def authorized
          header = request.headers['Authorization']
          token = header.split(' ')[1] if header
          begin
            decoded = JWT.decode(token, Rails.application.secrets.secret_key_base)
            @current_user = User.find(decoded[0]['user_id'])
          rescue
            render json: { error: 'Unauthorized' }, status: :unauthorized
          end
        end


end
