# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Articles', type: :request do
  describe 'new' do
    it 'shows an article form' do
      get '/articles/new'

      expect(response.body).to include('Title')
      expect(response.body).to include('Text')
    end
  end

  describe 'create' do
    let(:params) do
      { article: { title: 'Test', text: 'My first blog' } }
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
  end
end
