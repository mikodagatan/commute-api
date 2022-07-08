# frozen_string_literal: true

module Api
  # Responsible for handling CRUD of User.
  class UsersController < ApplicationController
    before_action :authorize_request, except: :create
    before_action :user, except: %i[create index]

    # GET /api/users
    def index
      @users = User.all
      render ::Response.show_success(@users, view: :normal)
    end

    # GET /api/users/{uuid}
    def show
      render ::Response.show_success(@users, view: :normal)
    end

    # POST /api/users
    def create
      @user = User.new(user_params)
      if @user.save
        render ::Response.create_success(@user)
      else
        render ::Response.create_error(@user)
      end
    end

    # PATCH /api/users/{uuid}
    def update
      if @user.update(update_params)
        render ::Response.update_success(@user)
      else
        render ::Response.update_error(@user)
      end
    end

    # DELETE /api/users/{uuid}
    def destroy
      if @user.delete
        render ::Response.destory_success(@user)
      else
        render ::Response.destroy_error
      end
    end

    private

    # Find user through UUID
    def user
      @user ||= User.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      not_found_error
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
