# frozen_string_literal: true

class ArticleForm
  include ActiveModel::Model

  attr_accessor :title, :text
end
