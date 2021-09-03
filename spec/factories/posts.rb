FactoryBot.define do
  factory :post do
    title { Faker::Hipster.paragraph_by_chars(characters: 100) }
    description { Faker::Hipster.paragraph(sentence_count: 5, supplemental: true) }
    upvotes { Faker::Number.between(from: 1, to: 10) }
    downvotes { Faker::Number.between(from: 1, to: 10) }
    user

    trait :with_one_image do
      images { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'support', 'assets', 'test-image5.jpg'), 'image/jpg') }
    end

    trait :with_images do
      images { [ Rack::Test::UploadedFile.new(Rails.root.join('spec', 'support', 'assets', 'test-image1.jpg'), 'image/jpg') ,
        Rack::Test::UploadedFile.new(Rails.root.join('spec', 'support', 'assets', 'test-image2.jpg'), 'image/jpg'),
        Rack::Test::UploadedFile.new(Rails.root.join('spec', 'support', 'assets', 'test-image3.jpg'), 'image/jpg') ]
       }
    end
  end
end
