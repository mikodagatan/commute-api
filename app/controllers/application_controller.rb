# frozen_string_literal: true

class ApplicationController < ActionController::API
  include Authorizeable
  before_action :authorize_request
end
