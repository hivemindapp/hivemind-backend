require 'rails_helper'

RSpec.describe Types::QueryType, type: :request do
  set_graphql_type

  describe 'posts' do
    types = GraphQL::Define::TypeDefiner.instance

    it 'lists all posts ordered by created date (newest to oldest)' do
      user1 = create(:user)
      user2 = create(:user)

      posts1 = create_list(:post, 5, user: user1)
      posts2 = create_list(:post, 5, user: user2)

      post '/graphql', params: { query: query }

      json = JSON.parse(response.body, symbolize_names: true)
      data = json[:data][:posts]

      expect(data).to be_an Array
      expect(data.length).to eq 10
      
      expect(data.first[:id]).to eq posts2.last.id.to_s
      expect(data.first[:title]).to eq posts2.last.title
      expect(data.first[:image]).to eq posts2.last.image
      expect(data.first[:upvotes]).to eq posts2.last.upvotes
      expect(data.first[:downvotes]).to eq posts2.last.downvotes
      expect(data.first[:createdAt]).to be_a String
      expect(data.first[:user]).to eq({ id: user2.id.to_s, username: user2.username, avatar: user2.avatar })
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
