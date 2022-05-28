class PlannedExpence < ApplicationRecord
  belongs_to :expence
  belongs_to :user
end
