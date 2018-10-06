# frozen_string_literal: true

module Write
  class Article
    include EventSourced
    attr_reader :id, :title, :text

    def initialize(id)
      @id = id
    end

    def article_created_handler(event)
      params = event.data.symbolize_keys

      @title = params[:title]
      @text = params[:text]
    end
  end
end
