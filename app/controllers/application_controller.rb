# frozen_string_literal: true

# Mother Class Controller for the application. Authorizes Request
class ApplicationController < ActionController::API
  include Authorizeable

  def not_found
    render json: { error: 'not_found' }, status: :not_found
  end
end
