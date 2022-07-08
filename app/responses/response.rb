# frozen_string_literal: true

class Response
  attr_reader :record, :custom_name, :view, :root

  # NOTE: Noticed the similarities of patterns with regards to some json responses.
  #  - If the response is different from normal, you can write them inline instead.
  #  - Recommended to use in order to have consistent responses.``
  #  - Can create as a gem.

  # Allows method calls to look like e.g. render ::Response.create_success(@record)
  #
  %w[
    not_found_error
    show_success
    create_success
    create_error
    update_success
    update_error
    destroy_success
    destroy_error
  ].map(&:to_s).each do |method_name|
    define_singleton_method method_name do |record = nil, **args|
      new(record, **args).send(method_name)
    end
  end

  def initialize(record = nil, custom_name: nil, view: nil, root: nil)
    @record = record
    @custom_name = custom_name
    @view = view
    @root = root
  end

  # E.g.
  # {
  #   error: 'Not found'
  # }
  #
  def not_found_error
    { json: { error: I18n.t('errors.messages.not_found', model: custom_name || model) },
      status: :not_found }
  end

  # Use for Index and show
  # E.g.
  # {
  #   users: [{ attr1: value1, attr2: value2 }]
  # }
  #
  def show_success
    { json: blueprint.render(record, view:, root:), status: :ok }
  end

  # E.g.
  # {
  #   user: { attr1: value1, attr2: value2 }
  # }
  #
  def create_success
    { json: blueprint.render(record, view:, root:), status: :created }
  end

  # E.g.
  # {
  #   errors: ['error 1', 'error 2'] }
  # }
  #
  def create_error
    { json: { errors: record.errors.full_messages }, status: :unprocessable_entity }
  end

  # E.g.
  # {
  #   user: { attr1: value1, attr2: value2 }
  # }
  #
  def update_success
    { json: blueprint.render(record, view:, root:), status: :ok }
  end

  # E.g.
  # {
  #   errors: ['error 1', 'error 2'] }
  # }
  def update_error
    { json: { errors: record.errors.full_messages },
      status: :not_acceptable }
  end

  # E.g.
  # {
  #   user: { attr1: value1, attr2: value2 },
  #   message: 'message description'
  # }
  #
  def destroy_success
    { json: { key => blueprint.render(record),
              message: I18n.t('errors.messages.deleted', model: key.gsub('_', ' ').titleize) },
      status: :ok }
  end

  # E.g.
  # {
  #   errors: ['error 1', 'error 2'] }
  # }
  def destroy_error
    { json: {
        errors: I18n.t('errors.messages.cant_delete', model: custom_name || model)
      },
      status: :not_acceptable }
  end

  private

  def klass_name
    record.send(record.is_a?(ActiveRecord::Relation) ? 'klass' : 'class').name
  end

  def model
    klass_name.split('::').last
  end

  def key
    model.underscore
  end

  # Overwrite if using another gem like blueprinter.
  # e.g. Transport::CompanyBlueprint
  def blueprint
    "#{klass_name}Blueprint".constantize
  end
end
