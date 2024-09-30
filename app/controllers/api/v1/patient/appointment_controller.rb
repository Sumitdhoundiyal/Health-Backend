class Api::V1::Patient::AppointmentController < ApplicationController


  skip_before_action :verify_authenticity_token
  before_action :set_appointment, only: [:show, :update, :destroy]

    def show
      render json: @appointment, include: [ :patient_information, :doctor, :hospital], status: :ok
    end

    def create
      @appointment = Appointment.new(appointment_params)

      if doctor_available?(@appointment.doctor_id, @appointment.appointment_date , @appointment.appointment_time)
        if @appointment.save
          render json: @appointment, status: :created
        else
          render json: { errors: @appointment.errors.full_messages }, status: :unprocessable_entity
        end
      else
        render json: { error: 'Doctor is not available at this time' }, status: :unprocessable_entity
      end
    end

    def update
      if doctor_available?(@appointment.doctor_id, appointment_params[:appointment_date])
        if @appointment.update(appointment_params)
          render json: @appointment, status: :ok
        else
          render json: { errors: @appointment.errors.full_messages }, status: :unprocessable_entity
        end
      else
        render json: { error: 'Doctor is not available at this time' }, status: :unprocessable_entity
      end
    end

    def destroy
      if @appointment.destroy
        render json: { message: 'Appointment deleted successfully' }, status: :ok
      else
        render json: { errors: @appointment.errors.full_messages }, status: :unprocessable_entity
      end
    end

    private

    def appointment_params
      params.require(:appointment).permit(:hospital_id, :doctor_id, :patient_information_id, :appointment_date)
    end

    def set_appointment
      @appointment = Appointment.find(params[:id])
    end

    def doctor_available?(doctor_id, appointment_date)
      overlapping_appointments = Appointment.where(doctor_id: doctor_id)
                                            .where('appointment_date = ?', appointment_date)

  skip_before_action :verify_authenticity_token
  .where('appointment_time >= ?', Time.now)
                                            .exists?
      !overlapping_appointments
    end
end
