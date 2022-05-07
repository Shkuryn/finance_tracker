# frozen_string_literal: true

class WelcomeController < ApplicationController
  def index
    @username ||= current_user.name if user_signed_in?
  end
end
