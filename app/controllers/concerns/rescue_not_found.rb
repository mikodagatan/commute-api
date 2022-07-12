# frozen_string_literal: true

module RescueNotFound
  extend ActiveSupport::Concern

  included do
    around_action :rescue_not_found, only: %i[index show new create edit update destroy login]
  end

  def index; end
  def show; end
  def new; end
  def create; end
  def edit; end
  def update; end
  def destroy; end
  def login; end

  def rescue_not_found
    yield
  rescue ActiveRecord::RecordNotFound => e
    render json: { error: I18n.t('errors.messages.not_found', model: e.message.split[2]) },
           status: :not_found
  end
end
