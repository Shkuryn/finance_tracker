# frozen_string_literal: true

module ApplicationHelper
  include OperationsHelper
  def username(user_id)
    user = User.find(user_id)
    user.name.to_s
  end

  def get_invitations
    Invitation.where(member_id: current_user.id, confirmed: false).count
  end
end
