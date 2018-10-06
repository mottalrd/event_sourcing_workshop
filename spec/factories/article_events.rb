# frozen_string_literal: true

FactoryBot.define do
  factory :article_created_event, parent: :base_event do
    event_type { 'created' }
    entity_type { 'article' }
    entity_id { SecureRandom.uuid }
    data do
      {
        title: 'My title',
        text: 'My text'
      }
    end
  end
end
