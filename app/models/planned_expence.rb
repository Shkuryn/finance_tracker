# frozen_string_literal: true

class PlannedExpence < ApplicationRecord
  belongs_to :expence
  belongs_to :user
end
