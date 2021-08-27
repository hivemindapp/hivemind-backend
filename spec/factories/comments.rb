FactoryBot.define do
  factory :comment do
    content { Faker::Books::Dune.quote }
    upvotes { Faker::Number.between(from: 1, to: 10) }
    downvotes { Faker::Number.between(from: 1, to: 10) }
    user
    post
  end
end
