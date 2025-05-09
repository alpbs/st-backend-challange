FactoryBot.define do
  factory :gasstation do
    name { Faker::Company.name }
    address { Faker::Address.full_address }
    price_per_liter { Faker::Number.decimal(l_digits: 2) }
  end
end
