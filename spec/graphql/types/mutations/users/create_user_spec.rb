require 'rails_helper'

RSpec.describe Mutations::Users::CreateUser, type: :request do
  set_graphql_type

  let!(:query) { 
    <<~GQL
      mutation {
        createUser(input: {
          username: "testusername",
          region: "Midwest",
          biography: "My Bio",
          avatar: "https://images/1"
        })
      }
    GQL
  }

  before :each do
    User.destroy_all
  end

  context 'creating a user' do
    it 'creates a user' do
      post '/graphql', params: { query: query }
      json_response = Oj.load(response.body, symbol_keys: true)

      user = User.first
      expect(user.username).to eq 'testusername'
      expect(user.region).to eq 'Midwest'
      expect(user.biography).to eq 'My Bio'
      expect(user.avatar).to eq 'https://images/1'
    end
  end
end