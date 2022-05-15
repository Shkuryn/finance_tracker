# frozen_string_literal: true

require 'rails_helper'

# Change this ArticlesController to your project
RSpec.describe WelcomeController, type: :controller do
  describe 'GET index' do
    it 'returns a 200' do
      get :index
      expect(response).to have_http_status(:ok)
    end
  end
end
