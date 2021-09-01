require 'rails_helper'

RSpec.describe Types::QueryType, type: :request do
  set_graphql_type

  describe 'posts' do
    types = GraphQL::Define::TypeDefiner.instance

    it 'lists all posts ordered by created date (newest to oldest)' do
      user1 = create(:user, :with_avatar)
      user2 = create(:user, :with_avatar)

      posts1 = create_list(:post, 5, :with_images, user: user1)
      posts1a = create_list(:post, 1, user: user2)
      posts2 = create_list(:post, 4, :with_one_image, user: user2)
      
      post '/graphql', params: { query: query }

      json = JSON.parse(response.body, symbolize_names: true)
      data = json[:data][:posts]

      expect(data).to be_an Array
      expect(data.length).to eq 10
      
      images = posts2.last.images.map do |image|
        rails_blob_url(image, only_path: true)
      end

      user = { id: user2.id.to_s, username: user2.username, avatar: rails_blob_url(user2.avatar, only_path: true) }

      expect(data.first[:id]).to eq posts2.last.id.to_s
      expect(data.first[:title]).to eq posts2.last.title
      expect(data.first[:imageUrls]).to eq images
      expect(data.first[:upvotes]).to eq posts2.last.upvotes
      expect(data.first[:downvotes]).to eq posts2.last.downvotes
      expect(data.first[:createdAt]).to be_a String
      expect(data.first[:user]).to eq(user)
    end

    it 'returns post type objects' do
      expect(subject).to have_field(:posts).of_type('[Post!]!')
    end

    def query
      <<~GQL
        query {
          posts {
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
