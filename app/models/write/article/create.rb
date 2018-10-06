# frozen_string_literal: true

module Write
  class Article
    CreateSchema = Dry::Validation.Schema do
      required(:title).filled
      required(:text).filled
    end

    class Create < Command
      def call
        return validate if validate.failure?

        publish_event(
          event_type: 'created',
          entity_type: 'article',
          entity_id: new_entity_id,
          data: @params
        )

        Response.new success: true, data: { new_entity_id: new_entity_id }
      end
    end
  end
end
