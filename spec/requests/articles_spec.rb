# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Articles', type: :request do
  describe 'new' do
    def do_request
      get '/articles/new'
    end

    it 'shows an article form' do
      do_request

      expect(response.body).to include('Title')
      expect(response.body).to include('Text')
    end
  end

  describe 'create' do
    let(:params) do
      { article_form: { title: 'Test', text: 'My first blog' } }
    end

    def do_request
      post '/articles', params: params
    end

    it 'creates an event' do
      expect do
        do_request
      end.to change {
        Event.where(entity_type: 'article', event_type: 'created').count
      }.from(0).to(1)
    end

    it 'redirects to the show page' do
      do_request

      new_entity_id = Event.last.entity_id

      expect(response).to redirect_to(article_path(new_entity_id))
    end

    context 'when form is invalid' do
      before do
        params[:article_form][:title] = nil
      end

      it 'does not redirect' do
        do_request

        expect(response).not_to have_http_status(:redirect)
      end

      it 'displays the error' do
        do_request

        expect(response.body).to include('Title must be filled')
      end
    end
  end

  describe 'show' do
    def do_request
      get "/articles/#{Event.last.entity_id}"
    end

    before do
      create(:article_created_event)
    end

    it 'shows the article' do
      do_request

      expect(response.body).to include('My title')
    end
  end

  describe 'index' do
    def do_request
      get '/articles'
    end

    before do
      create(:article_created_event)
      create(:article_created_event)
      create(:article_created_event)
    end

    it 'shows all the articles' do
      do_request

      expect(response.body).to have_css('.article', count: 3)
    end
  end
end
