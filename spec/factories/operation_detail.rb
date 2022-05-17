# frozen_string_literal: true

FactoryBot.define do
  factory :operation_detail do
    amount { '99.66' }
    comment { 'comment for operation detail' }
    created_at  { 1.days.ago }
    updated_at  { 1.days.ago }
    id { '1' }
  end
end
