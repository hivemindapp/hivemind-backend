FactoryBot.define do
  factory :user do
    username { Faker::Fantasy::Tolkien.character }
    region { Faker::Fantasy::Tolkien.location }
    biography { Faker::Fantasy::Tolkien.poem }
    # avatar { Faker::LoremFlickr.image(size: "500x500", search_terms: ['bear']) }
    
    trait :with_avatar do
      avatar { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'support', 'assets', 'test-image4.jpg'), 'image/jpg') }
    end
  end
end
