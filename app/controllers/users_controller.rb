# frozen_string_literal: true

class UsersController < ApplicationController
  helper OperationsHelper
  def show
    @user = User.find(params[:id])
    @invitations = Invitation.where(member_id: current_user.id, confirmed: false)

    @invitation = if Invitation.first.present?
                    Invitation.first
                  else
                    Invitation.new
                  end
  end

  def index
    @users = User.all
    @users = @users.emails(params[:email]) if params[:email].present?
  end
end
