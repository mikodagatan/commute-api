# frozen_string_literal: true

module Api
  module Transport
    class CompaniesController < ApplicationController
      before_action :company, except: %i[create index]

      # GET /api/transport/companies
      def index
        @companies = ::Transport::Company.all
        render ::Response.show_success(@companies, view: :normal)
      end

      # GET /api/transport/companies/{uuid}
      def show
        render ::Response.show_success(@company)
      end

      # POST /api/transport/companies
      def create
        @company = ::Transport::Company.new(company_params)
        if @company.save
          render ::Response.create_success(@company)
        else
          render ::Response.create_error(@company)
        end
      end

      # PATCH /api/transport/companies/{uuid}
      def update
        if @company.update(company_params)
          render ::Response.update_success(@company)
        else
          render ::Response.update_error(@company)
        end
      end

      # DELETE /api/transport/companies/{uuid}
      def destroy
        if @company.delete
          render ::Response.destroy_success(@company)
        else
          render ::Response.destroy_error(@company)
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
