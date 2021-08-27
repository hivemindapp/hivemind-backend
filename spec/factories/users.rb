FactoryBot.define do
  factory :user do
    username { Faker::Fantasy::Tolkien.character }
    region { Faker::Fantasy::Tolkien.location }
    biography { Faker::Fantasy::Tolkien.poem }
    avatar { Faker::LoremFlickr.image }
  end
end
