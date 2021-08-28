require 'rails_helper'

RSpec.describe Types::MutationType, type: :request do
  set_graphql_type

  describe 'create_post' do
    types = GraphQL::Define::TypeDefiner.instance

    it 'creates a new post for the given user' do
      user1 = create(:user)

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
