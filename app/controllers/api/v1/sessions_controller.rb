module Api
  module V1
    class SessionsController < ApplicationController
      skip_before_action :verify_authenticity_token

      def signup
        user = User.new(user_params)

        if user.save
          token = encode_token({ user_id: user.id })
          render json: { token: token, user: user }, status: :created
        else
          render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def login
        binding.pry
        user = User.find_by(email: params[:email])

        #if user&.authenticate(params[:password])
          token = encode_token({ user_id: user.id })
          render json: { token: token, user: user }, status: :ok
        #else
          #render json: { error: 'Invalid email or password' }, status: :unauthorized
        #end
      end

      private

      def encode_token(payload)
        JWT.encode(payload, Rails.application.secrets.secret_key_base)
      end

      def user_params
        params.permit(:email, :password, :password_confirmation)
      end
    end
  end
end
