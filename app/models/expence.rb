# frozen_string_literal: true

class Expence < ApplicationRecord
  belongs_to :user
  validates :name, length: { minimum: 3, maximum: 50 }, allow_blank: false
  has_many :operation_details, dependent: :delete_all
  scope :with_user, ->(user_id) { where('user_id = ?', user_id) }
  scope :with_family, lambda { |family_id|
    where('user_id IN (?)', User.with_family(family_id).pluck(:id))
  }
  scope :with_predefined, -> { where(predefined: true) }
  has_many :planned_expences, dependent: :delete_all
  before_destroy :check_predefined

  def check_predefined
    if predefined
      errors[:base] << 'cannot be deleted'
      false
    end
  end
end
