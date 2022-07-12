# frozen_string_literal: true

module Authorizeable
  extend ActiveSupport::Concern

  included do
    before_action :authorize_request
  end

  def authorize_request
    header = request.headers['Authorization']
    token = header.split.last if header
    begin
      decoded = ::JsonWebToken.decode(token)
      @current_user = User.find(decoded[:user_id])
    rescue StandardError => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end
end
