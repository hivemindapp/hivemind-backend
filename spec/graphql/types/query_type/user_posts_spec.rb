require 'rails_helper'

RSpec.describe Types::QueryType, type: :request do
  set_graphql_type

  describe 'user_posts' do
    types = GraphQL::Define::TypeDefiner.instance

    it 'lists all posts by the given user' do
      user1 = create(:user, :with_avatar)
      user2 = create(:user, :with_avatar)

      posts1 = create_list(:post, 3, :with_images, user: user1)
      posts1a = create_list(:post, 2, :with_one_image, user: user1)
      posts1b = create_list(:post, 2, user: user1)
      posts2 = create_list(:post, 5, user: user2)

      post '/graphql', params: { query: query(user_id: user1.id) }

      json = JSON.parse(response.body, symbolize_names: true)
      data = json[:data][:userPosts]
      
      expect(data).to be_an Array
      expect(data.length).to eq 7

      user = { id: user1.id.to_s, username: user1.username, avatar: rails_blob_url(user1.avatar, only_path: true) }

      expect(data.first[:id]).to eq user1.posts.last.id.to_s
      expect(data.first[:title]).to be_a String
      expect(data.first[:imageUrls]).to be_an Array
      expect(data.first[:upvotes]).to be_a Integer
      expect(data.first[:downvotes]).to be_a Integer
      expect(data.first[:createdAt]).to be_a String
      expect(data.first[:user]).to eq(user)
    end

    it 'returns post type objects' do
      expect(subject).to have_field(:userPosts).of_type('[Post!]!')
    end

    def query(user_id:)
      <<~GQL
        query {
          userPosts(userId: #{user_id}) {
            id
            title
            imageUrls
            upvotes
            downvotes
            createdAt
            user {
              id
              username
              avatar
            }
          }
        }
      GQL
    end
  end
end
