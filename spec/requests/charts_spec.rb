# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ChartsController, type: :controller do
  render_views
  before do
    # @user = FactoryBot.create(:user)
    # @operaton = FactoryBot.create(:operation, user_id: @user.id)
    # @expence = FactoryBot.create(:expence, user_id: @user.id)
    # @operaton_detail = FactoryBot.create(:operation_detail, operation_id: @operaton.id, expence_id: @expence.id)
    # allow(controller).to receive(:current_user).and_return(user)
  end

  describe 'GET index' do

    it 'returns a 200' do
      get :show
      expect(response).to have_http_status(:ok)
    end

    it 'has a related heading when  signed in' do
      user = FactoryBot.create(:user)
      sign_in user
      get :show
      expect(response.body).to match(/PieChart/im)
    end
  end

  after do
    # @user.destroy
    # @operaton.destroy
  end
end
