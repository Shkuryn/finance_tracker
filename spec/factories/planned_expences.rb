FactoryBot.define do
  factory :planned_expence do
    expence { nil }
    description { "MyString" }
    date { "2022-05-27 15:10:25" }
    sent { false }
    user { nil }
    amount { 1 }
  end
end
