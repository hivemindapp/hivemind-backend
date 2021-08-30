FactoryBot.define do
  factory :user do
    username { Faker::Fantasy::Tolkien.character }
    region { Faker::Fantasy::Tolkien.location }
    biography { Faker::Fantasy::Tolkien.poem }
    avatar { Faker::LoremFlickr.image(size: "500x500", search_terms: ['bear']) }
  end
end
