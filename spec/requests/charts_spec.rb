# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ChartsController, type: :controller do
  render_views
  before do
    @user = FactoryBot.create(:user)
    @operaton = FactoryBot.create(:operation, user_id: @user.id)
    @expence = FactoryBot.create(:expence, user_id: @user.id)
    @operaton_detail = FactoryBot.create(:operation_detail, operation_id: @operaton.id, expence_id: @expence.id)
  end

  describe 'GET index' do
    it 'returns a 200' do
      get :show
      expect(response).to have_http_status(:ok)
    end
    it 'to #show if not login' do
      get :show
      expect(response).to have_http_status(:ok)
      expect(response.body).to match(/<h3> please login/im)
    end

    it 'has a chart when  signed in' do
      sign_in @user
      get :show
      expect(response.body).to match(/Great name","99.66/im)
    end
  end

  after do
    @user.destroy
    @operaton.destroy
    @expence.destroy
    @operaton_detail.destroy
  end
end
