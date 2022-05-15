# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Hello world', type: :system do
  describe 'index page' do
    it 'shows the right content when guest visit' do
      visit root_path
      sleep(0.1)
      expect(page).to have_content('Welcome Guest!')
    end
  end
end