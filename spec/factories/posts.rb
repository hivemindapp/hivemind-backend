FactoryBot.define do
  factory :post do
    title { Faker::Books::Lovecraft.sentence }
    description { Faker::Books::Lovecraft.paragraph }
    image { Faker::LoremFlickr.image(size: "#{rand(200..600)}x#{rand(200..600)}", search_terms: ['bees', 'beehive']) }
    upvotes { Faker::Number.between(from: 1, to: 10) }
    downvotes { Faker::Number.between(from: 1, to: 10) }
    user
  end
end
