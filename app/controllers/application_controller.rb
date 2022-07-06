# frozen_string_literal: true

# Mother Class Controller for the application. Authorizes Request
class ApplicationController < ActionController::API
  def not_found
    render json: { error: 'not_found' }
  end

  def authorize_request
    header = request.headers['Authorization']
    token = header.split.last if header
    begin
      decoded = JsonWebToken.decode(token)
      @current_user = User.find(decoded[:user_id])
    rescue *EXCEPTIONS => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end
end
