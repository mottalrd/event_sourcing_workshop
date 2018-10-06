# frozen_string_literal: true

class Event < ActiveRecord::Base
  def self.create_and_broadcast(event_attributes)
    event = create!(event_attributes)

    begin
      LocalPublisher.call event
    rescue StandardError => e
      Rollbar.error(e, 'Could not broadcast event locally', event_attributes)
    end
  end
end
