require 'rails_helper'

RSpec.describe Types::QueryType, type: :request do
  set_graphql_type

  describe 'user' do
    types = GraphQL::Define::TypeDefiner.instance

    it 'returns user details' do
      user1 = create(:user, :with_avatar)

      post '/graphql', params: { query: query(id: user1.id) }

      json = JSON.parse(response.body, symbolize_names: true)
      data = json[:data][:user]

      user_avatar = rails_blob_url(user1.avatar, only_path: true)

      expect(data[:id]).to eq(user1.id.to_s)
      expect(data[:username]).to eq(user1.username)
      expect(data[:region]).to eq(user1.region)
      expect(data[:biography]).to eq(user1.biography)
      expect(data[:avatar]).to eq user_avatar
    end

    def query(id:)
      <<~GQL
        query {
          user(id: #{id}) {
            id
            username
            region
            biography
            avatar
          }
        }
      GQL
    end
  end
end
