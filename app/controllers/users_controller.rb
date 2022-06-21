# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @invitations = Invitation.where(member_id: current_user.id, confirmed: false )
    @invitation = Invitation.new
  end

  def index
    @users = User.all
    @users = @users.emails(params[:email]) if params[:email].present?
  end
end
