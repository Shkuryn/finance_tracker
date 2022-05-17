# frozen_string_literal: true

require 'rails_helper'

# Change this ArticlesController to your project
RSpec.describe WelcomeController, type: :controller do
  render_views
  describe 'GET index' do
    it 'returns a 200' do
      get :index
      expect(response).to have_http_status(:ok)
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template('index')
    end
    it 'has a related heading' do
      get :index
      expect(response.body).to match /<h1>Welcome/im
    end
  end

end
