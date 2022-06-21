# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @invitation = Invitation.new
  end

  def index
    @users = User.all
    @users = @users.emails(params[:email]) if params[:email].present?
  end
end
