# frozen_string_literal: true

class InvitationsController < ApplicationController
  before_action :set_invitation, only: %i[show edit update destroy]
  before_action :invitation_params, only: %i[show edit update destroy create]

  def create
    email = params[:invitation][:email]
    member = User.with_email(email)
    if member.blank?
      redirect_to current_user, alert: 'Email does not exist!'
    else

      @invitation = Invitation.new(user_id: current_user.id, member_id: member.first.id)

      respond_to do |format|
        if @invitation.save
          format.html { redirect_to current_user, notice: 'Invitation was successfully created.' }
          format.json { render :show, status: :created, location: @invitation }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @invitation.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def destroy
    invitation = Invitation.find(params[:invitation_id])
    invitation.destroy
    redirect_to current_user
  end

  def update
    invitation = Invitation.find(params[:invitation_id])
    invitation.update(confirmed: true)
    redirect_to current_user
  end

  private

  def set_invitation
    @invitation = Invitation.find(params[:id])
  end

  def invitation_params
    params.require(:invitation).permit(:user_id, :member_id, :confirmed, :id, :email)
  end
end
