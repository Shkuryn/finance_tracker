# frozen_string_literal: true

class Invitation < ApplicationRecord
  belongs_to :user
  scope :with_user, ->(user_id) { where('user_id = ?', user_id) }
  attr_accessor :email

  # def self.reacted?(id1, id2)
  #   case1 = !Invitation.where(user_id: id1, member_id: id2).empty?
  #   case2 = !Invitation.where(user_id: id2, member_id: id1).empty?
  #   case1 || case2
  # end
  #
  # def self.confirmed_record?(id1, id2)
  #   case1 = !Invitation.where(user_id: id1, member_id: id2, confirmed: true).empty?
  #   case2 = !Invitation.where(user_id: id2, member_id: id1, confirmed: true).empty?
  #   case1 || case2
  # end

  def self.find_invitation(id1, id2)
    Invitation.where(user_id: id1, member_id: id2)
  end
end
