FactoryBot.define do
  factory :comment do
    content { "MyString" }
    upvotes { 1 }
    downvotes { 1 }
    user { nil }
    post { nil }
  end
end
