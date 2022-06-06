# frozen_string_literal: true

class PlannedExpence < ApplicationRecord
  belongs_to :expences
  belongs_to :user
  scope :with_user, ->(user_id) { where('user_id = ?', user_id) }
end
