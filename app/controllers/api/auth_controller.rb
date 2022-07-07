# frozen_string_literal: true

module Api
  class AuthController < ApplicationController
    before_action :authorize_request, except: :login

    # POST /api/auth/login
    def login # rubocop:disable Metrics/MethodLength
      @user = User.find_by!(email: params[:email])

      if @user&.authenticate(params[:password])
        token = JsonWebToken.encode(user_id: @user.id)
        exp = Formats::DateTime.jwt(24.hours.from_now)
        render json: LoginBlueprint.render(@user, token:, exp:),
               status: :ok
      else
        render json: { error: t('errors.messages.unauthorized') },
               status: :unauthorized
      end
    rescue ActiveRecord::RecordNotFound
      not_found_error
    end

    private

    def login_params
      params.permit(:email, :password)
    end
  end
end
