# frozen_string_literal: true

module Api
  class AuthController < ApplicationController
    before_action :authorize_request, except: :login

    # POST /api/auth/login
    def login
      @user = User.find_by!(email: params[:email])

      if @user&.authenticate(params[:password])
        token = JsonWebToken.encode(user_id: @user.id)
        time = 24.hours.from_now.to_i
        render json: { token:, exp: time}

    rescue ActiveRecord::RecordNotFound
      render json: { error: "User (#{params[:email]}) not found" }, 
             status: :unprocessable_entity
    end

  end
end
