# frozen_string_literal: true

class Income < ApplicationRecord
  belongs_to :user
  self.primary_key = 'id'

  scope :with_user, ->(user_id) { where('user_id = ?', user_id) }
  scope :with_predefined, -> { where(predefined: true) }
end
