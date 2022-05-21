# frozen_string_literal: true

require 'rails_helper'
require 'requests_helper'

RSpec.describe 'Welcome page', type: :system do
  before do
    @user = FactoryBot.create(:user)
  end
  describe 'index page' do
    it 'shows the right content when guest visit' do
      visit root_path
      expect(page).to have_content('Welcome Guest!')
    end
    it 'shows the right content when user visit' do
      visit root_path
      login_user
      expect(page).to have_content('Welcome John!')
    end
  end
  describe 'visibility login/exit button' do
    it 'shows login button when guest' do
      visit root_path
      expect(have_link('Login', href: new_user_session_path))
      expect(have_no_link('exit', href: destroy_user_session_path))
    end
    it 'shows exit button when user singed_in' do
      visit root_path
      login_user
      expect(have_no_link('Login', href: new_user_session_path))
      expect(have_link('exit', href: destroy_user_session_path))
    end
  end
  after do
    @user.destroy
  end
end
