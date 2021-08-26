FactoryBot.define do
  factory :post do
    title { "MyString" }
    content { "MyString" }
    image { "MyString" }
    upvotes { 1 }
    downvotes { 1 }
    user { nil }
  end
end
