# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { 'John' }
    surname { 'Doe' }
    created_at  { 1.years.ago }
    updated_at  { 1.years.ago }
    email { 'Johndoe@example.com' }
    password { 'strong_1234' }

    # sequence(:username) { |n| "user#{n}" }
  end
end
