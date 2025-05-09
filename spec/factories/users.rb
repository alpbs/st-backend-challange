FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    balance { Faker::Number.decimal(l_digits: 2) * 1000 }
  end
end
