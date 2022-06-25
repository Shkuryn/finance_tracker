# frozen_string_literal: true

class WelcomeController < ApplicationController
  def index
    @username = user_signed_in? ? current_user.name : 'Guest'
  end
end
