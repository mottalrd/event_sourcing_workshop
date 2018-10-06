# frozen_string_literal: true

class ArticlesController < ApplicationController
  def new; end

  def create
    response = Write::Article::Create.new(article_params).call

    redirect_to article_path(response.data[:new_entity_id])
  end

  def show
    @article = 'Not yet'
  end

  private

  def article_params
    params.require(:article).permit(:title, :text)
  end
end
