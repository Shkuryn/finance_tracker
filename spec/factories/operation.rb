# frozen_string_literal: true

FactoryBot.define do
  factory :operation do
    id { 1 }
    comment { 'comment for operation' }
    marked { false }
    date { 1.days.ago }
    created_at  { 1.days.ago }
    updated_at  { 1.days.ago }
  end
end
