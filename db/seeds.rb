# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Comment.destroy_all
Post.destroy_all
User.destroy_all


op1 = FactoryBot.create(:user, :with_avatar)
op2 = FactoryBot.create(:user, :with_avatar)
commenter1 = FactoryBot.create(:user, :with_avatar)
commenter2 = FactoryBot.create(:user, :with_avatar)

FactoryBot.create_list(:post, 3, :with_images, user: op1) do |post|
  FactoryBot.create_list(:comment, 3, post: post, user: commenter1)
end

FactoryBot.create_list(:post, 2, :with_one_image, user: op1) do |post|
  FactoryBot.create_list(:comment, 2, post: post, user: commenter2)
end

FactoryBot.create_list(:post, 5, user: op1) do |post|
  FactoryBot.create_list(:comment, 1, post: post, user: commenter1)
  FactoryBot.create_list(:comment, 2, post: post, user: commenter2)
end

FactoryBot.create_list(:post, 3, :with_images, user: op1) do |post|
  FactoryBot.create_list(:comment, 3, post: post, user: commenter1)
end

FactoryBot.create_list(:post, 2, :with_images, user: op2) do |post|
  FactoryBot.create_list(:comment, 2, post: post, user: commenter1)
  FactoryBot.create_list(:comment, 3, post: post, user: commenter2)
  FactoryBot.create_list(:comment, 3, post: post, user: commenter1)
  FactoryBot.create_list(:comment, 4, post: post, user: commenter2)
end

FactoryBot.create_list(:post, 5, :with_one_image, user: op2)
