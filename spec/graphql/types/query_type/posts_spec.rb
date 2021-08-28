require 'rails_helper'

RSpec.describe "Posts", type: :request do
  describe '.resolve' do
    it 'lists all posts' do
      user1 = create(:user)
      user2 = create(:user)

      posts1 = create_list(:post, 5, user: user1)
      posts2 = create_list(:post, 5, user: user2)

      post '/graphql', params: { query: query }

      json = JSON.parse(response.body, symbolize_names: true)
      data = json[:data][:posts]
      
      expect(data).to be_an Array
      expect(data.length).to eq 10

      expect(data.first[:id]).to eq "1"
      expect(data.first[:title]).to be_a String
      expect(data.first[:image]).to be_a String
      expect(data.first[:upvotes]).to be_a Integer
      expect(data.first[:downvotes]).to be_a Integer
      expect(data.first[:createdAt]).to be_a String
      expect(data.first[:user]).to eq({ id: user1.id.to_s, username: user1.username, avatar: user1.avatar })
    end

    it 'returns objects that are post type' do

    end

    def query
      <<~GQL
        query {
          posts {
            id
            title
            image
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
