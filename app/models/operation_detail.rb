# frozen_string_literal: true

class OperationDetail < ApplicationRecord
  validates :operation_id, presence: true
  validates_numericality_of :amount, greater_than: 0.0
  belongs_to :operation
  validate :any_present?

  def any_present?
    return if %w[income_id expense_id].none? { |attr| self[attr].present? }

    errors.add :base, 'income or expense must be present'
  end
end
