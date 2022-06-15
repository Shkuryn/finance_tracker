# frozen_string_literal: true

class OperationDetail < ApplicationRecord
  validates :operation_id, presence: true
  validates_numericality_of :amount, greater_than: 0.0
  belongs_to :operation
  validate :any_present?

  def any_present?
    if %w[income_id expence_id].all? {|attr| self[attr].blank? }
      errors.add :base, 'income or expence must be present'
    end
  end
end
