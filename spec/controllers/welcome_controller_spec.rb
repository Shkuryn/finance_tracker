# frozen_string_literal: true

require 'rails_helper'
require 'requests_helper'

RSpec.describe 'Welcome page', type: :system do
  let(:user) { FactoryBot.create :user }
  describe 'index page' do
    it 'shows the right content when guest visit' do
      visit root_path
      expect(page).to have_content('Welcome !')
    end
    # it 'shows the right content when user visit' do
    #   visit root_path
    #   login_user user
    #   expect(page).to have_content('Welcome John!')
    # end
  end
  describe 'visibility Sign up/Log in button' do
    it 'shows login button when guest' do
      visit root_path
      expect(have_link('Sign up for free', href: new_user_registration_path))
      expect(have_link('Log in', href: new_user_session_path))
    end
    it 'shows exit button when user signed_in' do
      visit root_path
      login_user user
      expect(have_no_link('Login', href: new_user_session_path))
      expect(have_link('Sign out', href: destroy_user_session_path))
    end
  end
end
