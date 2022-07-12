# frozen_string_literal: true

module V1
  class ProfilesController < ApplicationController
    before_action :user

    # POST /api/profiles
    def create
      @profile = @user.build_profile(profile_params)
      if @profile.save
        render json: ProfileBlueprint.render(@profile), status: :created
      else
        render Respo.create_error(@profile)
      end
    end

    # PATCH /api/profiles/{user_uuid}
    def update
      @profile = @user.profile
      if @profile.update(profile_params)
        render json: ProfileBlueprint.render(@profile)
      else
        render Respo.update_error(@profile)
      end
    end

    # Deleted only if User is deleted. No need response
    def destroy
      @user.profile.delete
    end

    private

    def user
      @user ||= User.find(params[:user_id] || params[:id])
    end

    def profile_params
      params.require(:profile).permit(
        :birthday, :first_name, :middle_initial, :last_name, :sex
      )
    end
  end
end
