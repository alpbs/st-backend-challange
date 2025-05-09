FactoryBot.define do
  factory :refueling do
    user { create(:user) }
    gasstation { create(:gasstation) }
    price_per_liter { gasstation.price_per_liter }
    quantity { Faker::Number.decimal(l_digits: 2) * rand(3) }
    discount { (quantity * gasstation.price_per_liter) * RefuelingsServices::Create::DISCOUNT.to_f / 100 }
  end
end
