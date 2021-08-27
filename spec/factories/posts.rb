FactoryBot.define do
  factory :post do
    title { Faker::Books::Lovecraft.sentence }
    description { Faker::Books::Lovecraft.paragraph }
    image { Faker::LoremFlickr.image }
    upvotes { Faker::Number.between(from: 1, to: 10) }
    downvotes { Faker::Number.between(from: 1, to: 10) }
    user
  end
end
