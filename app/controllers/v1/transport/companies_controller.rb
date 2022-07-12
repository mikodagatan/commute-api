# frozen_string_literal: true

module V1
  module Transport
    class CompaniesController < ApplicationController
      before_action :company, except: %i[create index]

      def index
        @companies = ::Transport::Company.all
        render Respo.show_success(@companies)
      end

      def show
        render Respo.show_success(@company)
      end

      def create
        @company = ::Transport::Company.new(company_params)
        if @company.save
          render Respo.create_success(@company)
        else
          render Respo.create_error(@company)
        end
      end

      def update
        if @company.update(company_params)
          render Respo.update_success(@company)
        else
          render Respo.update_error(@company)
        end
      end

      def destroy
        if @company.delete
          render Respo.destroy_success(@company)
        else
          render Respo.destroy_error(@company)
        end
      end

      private

      def company
        @company ||= ::Transport::Company.find(params[:id])
      end

      def company_params
        params.require(:company).permit(:name, :owner_id)
      end
    end
  end
end
