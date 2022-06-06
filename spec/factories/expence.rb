# frozen_string_literal: true

FactoryBot.define do
  factory :expences do
    id { '1' }
    name { 'Great name' }
    description { 'Good description' }
    created_at  { 1.years.ago }
    updated_at  { 1.years.ago }
    predefined { false }
  end
end
