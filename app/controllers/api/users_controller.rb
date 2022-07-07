# frozen_string_literal: true

module Api
  # Responsible for handling CRUD of User.
  class UsersController < ApplicationController
    before_action :authorize_request, except: :create
    before_action :user, except: %i[create index]

    # GET /api/users
    def index
      @users = User.all
      render json: UserBlueprint.render(@users, view: :normal), status: :ok
    end

    # GET /api/users/{uuid}
    def show
      render json: UserBlueprint.render(@user, view: :normal), status: :ok
    end

    # POST /api/users
    def create
      @user = User.new(user_params)
      if @user.save
        render json: UserBlueprint.render(@user), status: :created
      else
        render json: { errors: @user.errors.full_messages },
               status: :unprocessable_entity
      end
    end

    # PATCH /api/users/{uuid}
    def update
      if @user.update(update_params)
        render json: UserBlueprint.render(@user), status: :ok
      else
        render json: { errors: @user.errors.full_messages },
               status: :not_acceptable
      end
    end

    # DELETE /api/users/{uuid}
    def destroy
      @user.destroy
    end

    private

    # Find user through UUID
    def user
      @user ||= User.find!(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { errors: 'User not found' }, staus: :not_found
    end

    def user_params
      params.permit(
        :avatar, :email, :password, :password_confirmation, :id
      )
    end

    def update_params
      params.permit(:email)
    end
  end
end
