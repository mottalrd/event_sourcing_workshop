# frozen_string_literal: true

module EventSourcingWorkshop
  class Application < Rails::Application
    config.to_prepare do
      LocalPublisher.subscribe Article, on: :article_created
    end
  end
end
