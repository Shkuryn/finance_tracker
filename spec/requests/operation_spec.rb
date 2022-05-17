# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OperationsController, type: :controller do
  before do
    @user = FactoryBot.create(:user)
    @operaton = FactoryBot.create(:operation, user_id: @user.id)
  end

  describe 'GET index' do
    it 'returns a 200' do
      get :index
      expect(response).to have_http_status(:ok)
    end
  end
  describe 'GET show' do
    it 'to #show' do
      get :show, params: { id: @operaton }
    end
  end
  after do
    @user.destroy
    @operaton.destroy
  end
end
