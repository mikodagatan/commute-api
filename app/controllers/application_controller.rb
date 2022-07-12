# frozen_string_literal: true

class ApplicationController < ActionController::API
  include Authorizeable
  include RescueNotFound
end
