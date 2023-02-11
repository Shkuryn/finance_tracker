# frozen_string_literal: true

module PlannedExpencesHelper
  def planned_expence_name(expence_id)
    Expence.find(expence_id).name
  end
  def send_email(user_id)
    User.find(user_id)
  end
end
