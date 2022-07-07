# frozen_string_literal: true

module Api
  module Transport
    class CompaniesController < ApplicationController
      before_action :authorize_request
      before_action :company, except: %i[create index]

      # GET /api/transport/companies
      def index
        companies = ::Transport::Company.all
        render json: blueprint.render(companies),
               status: :ok
      end

      # GET /api/transport/companies/{uuid}
      def show
        render json: blueprint.render(@company),
               status: :ok
      end

      # POST /api/transport/companies
      def create
        @company = ::Transport::Company.new(company_params)
        if @company.save
          render json: blueprint.render(@company),
                 status: :created
        else
          create_error(@company)
        end
      end

      # PATCH /api/transport/companies/{uuid}
      def update
        if @company.update(company_params)
          render json: blueprint.render(@company, root: 'company'),
                 status: :ok
        else
          update_error(@company)
        end
      end

      # DELETE /api/transport/companies/{uuid}
      def destroy
        if @company.delete
          render json: 'deleted', status: :ok
        else
          destroy_error
        end
      end

      private

      def company
        @company ||= ::Transport::Company.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        not_found_error
      end

      def company_params
        params.permit(:name, :owner_id)
      end

      def blueprint
        ::Transport::CompanyBlueprint
      end
    end
  end
end
