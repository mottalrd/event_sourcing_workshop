# frozen_string_literal: true

class LocalPublisher
  include Wisper::Publisher

  def self.call(event)
    new.send(:broadcast, "#{event.entity_type}_#{event.event_type}", event)
  end
end
