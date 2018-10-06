# frozen_string_literal: true

class ArticlesController < ApplicationController
  def new
    @article_form = ArticleForm.new
  end

  def create
    response = Write::Article::Create.new(article_params).call

    if response.success?
      redirect_to article_path(response.data[:new_entity_id])
    else
      @article_form = ArticleForm.new
      response.errors.add_to(@article_form)
      render :new
    end
  end

  def show
    @article = Write::Article.find(params[:id])
  end

  private

  def article_params
    params.require(:article_form).permit(:title, :text)
  end
end
