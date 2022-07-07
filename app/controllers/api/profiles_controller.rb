# frozen_string_literal: true

module Api
  class ProfilesController < ApplicationController
    before_action :user

    # POST /api/profiles
    def create
      @profile = @user.build_profile(profile_params)
      if @profile.save
        render json: ProfileBlueprint.render(@profile), status: :created
      else
        create_error(@profile)
      end
    end

    # PATCH /api/profiles/{user_uuid}
    def update
      @profile = @user.profile
      if @profile.update(profile_params)
        render json: ProfileBlueprint.render(@profile)
      else
        update_error(@profile)
      end
    end

    # Deleted only if User is deleted
    def destroy
      @profile = @user.profile.delete
    end

    private

    def user
      @user ||= User.find(params[:user_id] || params[:id])
    rescue ActiveRecord::RecordNotFound
      not_found_error('User')
    end

    def profile_params
      params.permit(
        :birthday, :first_name, :middle_initial, :last_name, :sex
      )
    end
  end
end
