# frozen_string_literal: true

FactoryBot.define do
  factory :base_event, class: Event do
    after(:create) do |event|
      LocalPublisher.call(event)
    end
  end
end
