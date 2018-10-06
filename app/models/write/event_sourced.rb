# frozen_string_literal: true

module Write
  module EventSourced
    def self.included(base)
      base.send :include, InstanceMethods
      base.extend ClassMethods
    end

    module InstanceMethods
      def handle(event)
        handler_name = "#{event.entity_type}_#{event.event_type}_handler"
        send(handler_name.to_sym, event) if respond_to? handler_name
      end
    end

    module ClassMethods
      def find(id)
        entity = new(id)
        load_events_for(entity)
        entity
      end

      def load_events_for(entity)
        events = Event.where(
          entity_type: to_s.split('::').last.downcase,
          entity_id: entity.id
        )
        events.each { |event| entity.handle(event) }
      end
    end
  end
end
