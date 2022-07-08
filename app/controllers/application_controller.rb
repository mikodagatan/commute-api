# frozen_string_literal: true

class ApplicationController < ActionController::API
  include Authorizeable

  before_action :authorize_request

  # rescue_from ActiveRecord::RecordNotFound, with: :render_record_not_found
end
