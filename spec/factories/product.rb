FactoryGirl.define do
  factory :product do
    asin { Faker::Code.asin }
    title { Faker::Commerce.product_name }
    review_count { Faker::Number.number(2) }
    price { Faker::Number.decimal(2) }
  end
end
