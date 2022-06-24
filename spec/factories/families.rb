# frozen_string_literal: true

FactoryBot.define do
  factory :family do
    name { 'John' }
    parent_id { nil }
    created_at { 1.years.ago }
    updated_at { 1.years.ago }
  end
end
