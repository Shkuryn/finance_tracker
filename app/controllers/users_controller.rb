# frozen_string_literal: true

class UsersController < ApplicationController
  helper OperationsHelper
  before_action :check_user_signed
  around_action :user_not_found

  def show
    @user = User.find(params[:id])
    if current_user != @user
      redirect_to current_user, alert: 'Sorry, This Profile belongs to someone else !'
    end
    @invitations = Invitation.where(member_id: current_user.id, confirmed: false)
    @invitation = if Invitation.first.present?
                    Invitation.first
                  else
                    Invitation.new
                  end
    @new_invitation = Invitation.new

    @family = User.with_family(current_user.family_id)
    @family_member = current_user.family_member?
  end

  def index
    @users = User.all
    @users = @users.emails(params[:email]) if params[:email].present?
  end

  private

  def check_user_signed
    render template: 'welcome/index' unless user_signed_in?
  end

  def user_params
    params.require(:user).permit(:id)
  end

  def user_not_found
    yield
  rescue ActiveRecord::RecordNotFound
    redirect_to current_user, :flash => { :alert => 'User not found.' }
  end
end
