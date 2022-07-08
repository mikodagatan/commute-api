# frozen_string_literal: true

module API
  module Transport
    class DriverProfilesController < ApplicationController
      before_action :driver, except: %i[index create]

      # GET api/transport/drivers
      def index
        # TODO
        @drivers = ::Transport::DriverProfile.all
        render ::Response.show_success(@drivers, root: 'drivers')
      end

      # POST api/transport/drivers
      def create
        @driver = ::Transport::DriverProfile.new(driver_params)
        if @driver.save
          render ::Response.create_success(@driver, root: 'driver')
        else
          render ::Response.create_error(@driver)
        end
      end

      # PATCH api/transport/drivers/{uuid}
      def update
        if @driver.update(driver_params)
          render ::Response.update_success(@driver)
        else
          render ::Response.update_error(@driver)
        end
      end

      # DELETE api/transport/drivers/{uuid}
      def destroy
        if @driver.delete
          render ::Response.destroy_success(@driver)
        else
          render ::Response.destroy_error(@driver)
        end
      end

      private

      def driver_params
        params.require(:driver_profile).permit(:id, :user_id, :license_number)
      end

      def driver
        @driver ||= ::Transport::DriverProfile.find(id: params[:id])
      rescue ActiveRecord::RecordNotFound
        render ::Response.not_found_error('Driver')
      end
    end
  end
end
