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
end
