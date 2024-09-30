module Api
  module V1
    class SessionsController < ApplicationController
      skip_before_action :verify_authenticity_token

      def create
        user = User.find_by(email: params[:session][:email]) # Assuming nested params

        if user&.authenticate(params[:session][:password])
          session[:user_id] = user.id
          render json: { status: 'logged_in', user: user }
        else
          render json: { status: 'error', message: 'Invalid email or password' }, status: :unauthorized
        end
      end

      def destroy
        session[:user_id] = nil
        render json: { status: 'logged_out' }
      end
    end
  end
end
