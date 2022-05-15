# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ExpencesController, type: :controller do
  before do
    @user = FactoryBot.create(:user)
    @expence = FactoryBot.create(:expence, user_id: @user.id)
  end
  describe 'GET index' do
    it 'returns a 200' do
      get :index
      expect(response).to have_http_status(:ok)
    end
    describe 'GET show' do
      it 'to #show' do
        get :show, params: { id: @expence }
      end
    end
  end
  after do
    @user.destroy
    @expence.destroy
  end
end
