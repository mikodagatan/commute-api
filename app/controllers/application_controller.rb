# frozen_string_literal: true

# Mother Class Controller for the application. Authorizes Request
class ApplicationController < ActionController::API
  include Authorizeable

  private

  def not_found_error(custom_name = nil)
    render json: {
             errors: [I18n.t('errors.messages.not_found', model: custom_name || model(custom_name))]
           },
           status: :not_found
  end

  def create_error(record)
    render json: { errors: record.errors.full_messages },
           status: :unprocessable_entity
  end

  def update_error(record)
    render json: { errors: record.errors.full_messages },
           status: :not_acceptable
  end

  def destroy_error(custom_name = nil)
    render json: {
             errors: [I18n.t('errors.messages.cant_delete', model: custom_name || model(custom_name))]
           },
           status: :not_acceptable
  end

  def model
    controller_name.singularize.capitalize
  end

end
