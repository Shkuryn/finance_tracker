# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :incomes, dependent: :destroy
  has_many :expences, dependent: :destroy
  has_many :operations, dependent: :destroy
  has_many :invitations
  has_many :pending_invitations, -> { where confirmed: false }, class_name: 'Invitation', foreign_key: 'member_id'

  def members
    members_i_sent_invitation = Invitation.where(user_id: id, confirmed: true).pluck(:member_id)
    members_i_got_invitation = Invitation.where(member_id: id, confirmed: true).pluck(:user_id)
    ids = members_i_sent_invitation + members_i_got_invitation
    User.where(id: ids)
  end

  def family_member?(user)
    Invitation.confirmed_record?(id, user.id)
  end

  def send_invitation(user)
    invitations.create(member_id: user.id)
  end
end
