# frozen_string_literal: true

class Article < ApplicationRecord
  class << self
    def article_created(event)
      params = event.data.symbolize_keys

      create!(title: params[:title], text: params[:text])
    end
  end
end
