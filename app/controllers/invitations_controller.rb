# frozen_string_literal: true

class InvitationsController < ApplicationController
  helper OperationsHelper
  before_action :set_invitation, only: %i[show edit destroy]
  before_action :invitation_params, only: %i[show edit destroy create]

  def create
    email = params[:invitation][:email]
    members = User.with_email(email)
    if members.blank?
      redirect_to current_user, alert: 'Email does not exist!'
    elsif email == current_user.email
      redirect_to current_user, alert: 'You can not invite yourself!'
    elsif members.first.family_id.present? && members.first.family_id == current_user.family_id
      redirect_to current_user, alert: "User #{members.first.email} already in your family"
    elsif members.first.family_id.present? && members.first.family_id != current_user.family_id
      redirect_to current_user, alert: "User #{members.first.email} belongs to other family"
    elsif Invitation.find_invitation(current_user.id, members.first.id).present?
      redirect_to current_user, alert: "Invitation was created before"
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
    invitation = Invitation.find(params[:id])
    invitation.destroy
    redirect_to current_user
  end

  def update

    invitation = Invitation.find(params[:id])
    invitation.update(confirmed: true)
    family = create_family(invitation)
    update_family_attributes(family, invitation)
    redirect_to current_user
  end

  private

  def set_invitation
    @invitation = Invitation.find(params[:id])
  end

  def invitation_params
    params.require(:invitation).permit(:user_id, :member_id, :confirmed, :id, :email)
  end

  def create_family(invitation)
    parent = User.find(invitation.user_id)
    if parent.family_id.blank?
      family = Family.new
      family.parent_id = parent.id
      family.name = "#{parent.surname}'s family"
      family.save
    else
      family = Family.find(parent.family_id)
    end
    family
  end

  def update_family_attributes(family, invitation)

    parent = User.find(invitation.user_id)
    if parent.family_id.blank?
      parent.family_id = family.id
      parent.save
    end

    member = User.find(invitation.member_id)
    member.family_id = family.id
    member.save
  end

end
