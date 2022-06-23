# frozen_string_literal: true

FactoryBot.define do
  factory :invitation do
    id { 1 }
    user_id { nil }
    member_id { nil }
    confirmed { false }
  end
end
