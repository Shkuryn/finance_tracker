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
  scope :with_email, ->(email) { where('email = ?', email) }

  def family_member?
    return false if family_id.blank?
    id != Family.find(family_id).parent_id
  end

  def family_parent?
    return false if family_id.blank?
    id == Family.find(family_id).parent_id
  end

end
