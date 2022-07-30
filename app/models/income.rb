# frozen_string_literal: true

class Income < ApplicationRecord
  belongs_to :user
  validates :name, length: { minimum: 3, maximum: 50 }, allow_blank: false
  self.primary_key = 'id'
  validates :name, length: { minimum: 3, maximum: 50 }, allow_blank: false
  has_many :operation_details, dependent: :delete_all
  scope :with_user, ->(user_id) { where('user_id = ?', user_id) }
  scope :with_family, lambda { |family_id|
    where('user_id IN (?)', User.with_family(family_id).pluck(:id))
  }

  def fill_default(user_id)
    self.user_id = user_id
  end
end
