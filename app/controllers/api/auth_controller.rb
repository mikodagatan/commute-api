# frozen_string_literal: true

module Api
  class AuthController < ApplicationController
    before_action :authorize_request, except: :login

    # POST /api/auth/login
    def login # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
      @user = User.find_by!(email: params[:email])

      if @user&.authenticate(params[:password])
        token = JsonWebToken.encode(user_id: @user.id)
        time = 24.hours.from_now.to_i
        render json: { token:,
                       exp: Formats::DateTime.jwt(time),
                       email: @user.email },
               status: :ok
      else
        render json: { error: 'unauthorized' }, status: :unauthorized
      end
    rescue ActiveRecord::RecordNotFound
      render json: { error: "User (#{params[:email]}) not found" },
             status: :unprocessable_entity
    end

    private

    def login_params
      params.permit(:email, :password)
    end
  end
end
