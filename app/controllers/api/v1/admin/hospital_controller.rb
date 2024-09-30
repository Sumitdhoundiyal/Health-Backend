module Api
  module V1
    module Admin
      class HospitalController < ApplicationController

        skip_before_action :verify_authenticity_token
        before_action :set_hospital, only: [:update, :show, :destroy]

        def index
          hospitals = ::Hospital.all
          render json: hospitals, status: :ok
        end

        def create
          hospital = ::Hospital.new(hospital_params)
          if hospital.save
            render json: hospital, status: :created
          else
            render json: hospital.errors, status: :unprocessable_entity
          end
        end

        def show
          render json: @hospital, status: :ok
        end

        def update
          if @hospital.update(hospital_params)
            render json: @hospital, status: :ok
          else
            render json: @hospital.errors, status: :unprocessable_entity
          end
        end


        def destroy
          if @hospital.destroy
            render json: { message: 'Hospital deleted successfully' }, status: :ok
          else
            render json: @hospital.errors, status: :unprocessable_entity
          end
        end

        private

        def set_hospital
          @hospital = ::Hospital.find(params[:id])
        end

        def hospital_params
          params.require(:hospital).permit(:hospital_name, :hospital_address_line1, :hospital_address_line2, :hospital_address_line3, :contact_number, :email, :hospital_type)
        end
      end
    end
  end
end
