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
  belongs_to :family, optional: true
  has_one :family_parent, class_name: 'Family', foreign_key: 'parent_id'
  scope :with_family, ->(family_id) { where('family_id = ?', family_id) }
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

  def self.emails(email)
    user = all
    user = user.where("email LIKE ?", "%#{email}%")
    return user
  end
end
