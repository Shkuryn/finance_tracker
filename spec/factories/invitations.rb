FactoryBot.define do
  factory :invitation do
    user { nil }
    member_id { 1 }
    confirmed { false }
  end
end
