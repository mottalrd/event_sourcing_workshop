# frozen_string_literal: true

class Response
  attr_reader :errors, :data

  def initialize(success:, data: nil, errors: {}, error: nil)
    @success = success
    @data = data
    @errors = if error.present?
                Errors.new(error)
              else
                Errors.new(errors)
              end
  end

  def success?
    @success
  end

  def failure?
    !success?
  end

  def error
    errors.first
  end
end
