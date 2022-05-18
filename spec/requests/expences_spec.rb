# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ExpencesController, type: :controller do
  render_views
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
      it 'to #show if not login' do
        get :show, params: { id: @expence }
        expect(response).to have_http_status(:ok)
        expect(response.body).to match(/<h3> please login/im)
      end
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template('index')
    end
    it 'has a related heading when not signed in' do
      get :index
      expect(response.body).to match(/<h3> please login/im)
    end

    it 'has a related heading when  signed in' do
      visit new_user_session_path
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      click_on 'commit'
      visit expences_path
      expect(page).to have_content('Expences')
      expect(page).to have_content('Great name')
    end
  end
  describe 'POST expence#create' do
    it 'should create a new expence' do
      visit new_expence_path
      sleep(5)
      Rails.logger.debug('START!')
      Rails.logger.debug(page.inspect)
      expect(page).to have_content('New Expence')
    end
  end
  after do
    @user.destroy
    @expence.destroy
  end
end
