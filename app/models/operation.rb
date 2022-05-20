# frozen_string_literal: true

class Operation < ApplicationRecord
  validates :date,
            inclusion: { in: 5.years.ago..5.years.from_now }
  has_many :operation_details, dependent: :destroy
  scope :with_user, ->(user_id) { where('user_id = ?', user_id) }
end
