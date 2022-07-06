# frozen_string_literal: true

class Service
  class << self
    def call(*params)
      new(params).call
    end
  end
end
