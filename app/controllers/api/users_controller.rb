# frozen_string_literal: true

module API
  # Responsible for handling CRUD of User.
  class UsersController < ApplicationController
    before_action :authorize_request, except: :create
    before_action :user, except: %i[create index]

    # GET /api/users
    def index
      @users = User.includes(:profile).all
      render Respo.index_success(@users)
    end

    # GET /api/users/{uuid}
    def show
      render Respo.show_success(@user)
    end

    # POST /api/users
    def create
      @user = User.new(user_params)
      if @user.save
        render Respo.create_success(@user)
      else
        render Respo.create_error(@user)
      end
    end

    # PATCH /api/users/{uuid}
    def update
      if @user.update(update_params)
        render Respo.update_success(@user)
      else
        render Respo.update_error(@user)
      end
    end

    # DELETE /api/users/{uuid}
    def destroy
      if @user.delete
        render Respo.destory_success(@user)
      else
        render Respo.destroy_error
      end
    end

    private

    # Find user through UUID
    def user
      @user ||= User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(
        :avatar, :email, :password, :password_confirmation, :id
      )
    end

    def update_params
      params.require(:user).permit(:email)
    end
  end
end
