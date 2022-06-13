# frozen_string_literal: true

FactoryBot.define do
  factory :income do
    id { '1' }
    name { 'Income name' }
    description { 'inc desc' }
    created_at  { 1.years.ago }
    updated_at  { 1.years.ago }
    predefined { false }
  end
end
