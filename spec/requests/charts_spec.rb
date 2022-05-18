# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ChartsController, type: :controller do
  before do
    # @user = FactoryBot.create(:user)
    # @operaton = FactoryBot.create(:operation, user_id: @user.id)
    # @expence = FactoryBot.create(:expence, user_id: @user.id)
    # @operaton_detail = FactoryBot.create(:operation_detail, operation_id: @operaton.id, expence_id: @expence.id)
  end

  describe 'GET index' do
    it 'returns a 200' do
      get :show
      expect(response).to have_http_status(:ok)
    end

    it 'has a related heading when  signed in' do
      # visit new_user_session_path
      # fill_in 'user_email', with: @user.email
      # fill_in 'user_password', with: @user.password
      # click_on 'commit'
      # visit charts_show_path
      # sleep(5)
      # assert_response :success
      # expect(page).to have_content('Expences')

    end
  end

  # after do
  #   @user.destroy
  #   @operaton.destroy
  # end
end
