# frozen_string_literal: true

module PlannedExpencesHelper
  def planned_expence_name(expence_id)
    expence = Expence.find(expence_id).name
  end
end
