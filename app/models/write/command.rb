# frozen_string_literal: true

module Write
  class Command
    def initialize(params)
      @params = params
      @validator = schema.call(params)
    end

    def publish_event(params)
      Event.create_and_broadcast(params)
    end

    def validate
      if @validator.success?
        Response.new(success: true)
      else
        Response.new(success: false, errors: @validator.errors)
      end
    end

    def schema
      "#{self.class.name}Schema".constantize
    end

    def new_entity_id
      @new_entity_id ||= SecureRandom.uuid
    end
  end
end
