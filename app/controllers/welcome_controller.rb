# frozen_string_literal: true

class WelcomeController < ApplicationController
  def index
    user_signed_in? ? @username = current_user.name  : @username = 'Guest'
  end
end
