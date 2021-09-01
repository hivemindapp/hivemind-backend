FactoryBot.define do
  factory :post do
    title { Faker::Books::Lovecraft.sentence }
    description { Faker::Books::Lovecraft.paragraph }
    # image { Faker::LoremFlickr.image(size: "#{rand(900..4000)}x#{rand(900..4000)}", search_terms: ['bees', 'beehive']) }
    upvotes { Faker::Number.between(from: 1, to: 10) }
    downvotes { Faker::Number.between(from: 1, to: 10) }
    user

    trait :with_one_image do
      images { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'support', 'assets', 'test-image1.jpg'), 'image/jpg') }
    end

    trait :with_images do
      images { [ Rack::Test::UploadedFile.new(Rails.root.join('spec', 'support', 'assets', 'test-image1.jpg'), 'image/jpg') ,
        Rack::Test::UploadedFile.new(Rails.root.join('spec', 'support', 'assets', 'test-image2.jpg'), 'image/jpg'),
        Rack::Test::UploadedFile.new(Rails.root.join('spec', 'support', 'assets', 'test-image3.jpg'), 'image/jpg') ]
       }
    end
  end
end
