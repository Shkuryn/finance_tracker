# frozen_string_literal: true

require 'rails_helper'
require 'requests_helper'

RSpec.describe 'Welcome page', type: :system do
  describe 'index page' do
    it 'shows the right content when guest visit' do
      visit root_path
      sleep(0.1)
      expect(page).to have_content('Welcome Guest!')
    end
    it 'shows the right content when user visit' do
      user = FactoryBot.create(:user)
      visit new_user_session_path
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password
      click_on 'commit'
      expect(page).to have_content('Welcome John!')
    end
  end
end
