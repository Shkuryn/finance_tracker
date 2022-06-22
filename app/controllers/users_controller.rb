# frozen_string_literal: true

class UsersController < ApplicationController

  before_action :check_user_signed

  def show
    @user = User.find(params[:id])
    if current_user != @user
      redirect_to root_url, alert: "Sorry, This Profile belongs to someone else !"
    end
    @invitation = Invitation.new
  end

  def index
    @users = User.all
    @users = @users.emails(params[:email]) if params[:email].present?
  end
end


  private

  def check_user_signed
    render template: 'welcome/index' unless user_signed_in?
  end

  def user_params
    params.require(:user).permit(:id)
  end
