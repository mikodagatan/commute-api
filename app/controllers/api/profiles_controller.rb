module Api
  class ProfilesController < ApplicationController
    # POST /api/profiles
    def create
      @profile = @user.profile.build(profile_params)
      if @profile.save
        render json: ProfileBlueprint.render(@profile), status: :created
      else
        render json: { errors: @profile.errors.full_messages },
               status: :unprocessable_entity
      end
    end

    # PATCH /api/profiles/{uuid}
    def update
      @profile = @user.profile
      if @profile.update(profile_params)
        render json: ProfileBlueprint.render(@profile)
      else
        render json: { errors: @profile.errors.full_messages },
               status: :not_acceptable
      end
    end

    private

    def user
      @user ||= User.find!(id: params[:user_id])
    rescue ActiveRecord::RecordNotFound
      render json: { errors: 'User not found' }, status: :not_found
    end

    def profile_params
      params.require(:profile).permit(
        :birthday, :first_name, :middle_initial, :last_name, :sex
      )
    end
  end
end
