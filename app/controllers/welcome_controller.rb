# frozen_string_literal: true

class WelcomeController < ApplicationController
  def index
    if user_signed_in?
     @username  ||= current_user.name
    end
  end
end
