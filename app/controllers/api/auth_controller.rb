# frozen_string_literal: true

module Api
  class AuthController < ApplicationController
    before_action :authorize_request, except: :login
    before_action :user

    # POST /api/auth/login
    def login
      if @user&.authenticate(params[:password])
        token = JsonWebToken.encode(user_id: @user.id)
        exp = Formats::DateTime.jwt(24.hours.from_now)
        render json: LoginBlueprint.render(@user, token:, exp:), status: :ok
      else
        render json: { error: t('errors.messages.unauthorized') }, status: :unauthorized
      end
    end

    private

    def login_params
      params.permit(:email, :password)
    end

    def user
      @user ||= User.find_by!(email: params[:email])
    rescue ActiveRecord::RecordNotFound
      render ::Response.not_found_error(custom_name: 'User')
    end
  end
end
