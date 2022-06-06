# frozen_string_literal: true

class OperationDetail < ApplicationRecord
  validates :operation_id, presence: true
  validates_numericality_of :amount, greater_than: 0.0
  belongs_to :operation
end
