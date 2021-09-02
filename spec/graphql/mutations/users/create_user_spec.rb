require 'rails_helper'

RSpec.describe Mutations::Users::CreateUser, type: :request do
  set_graphql_type

  let!(:query) { 
    <<~GQL
      mutation createUser {
        createUser(input: {
          username: "testusername",
        }) {
          id
          username
        }
      }
    GQL
  }

  before :each do
    Post.destroy_all
    User.destroy_all
  end

  it 'creates a new post for the given user' do
    expect do
      post '/graphql', params: { query: query }
    end.to change{ User.all.count }.by(1)
  end

  context 'creating a user' do
    it 'creates a user' do
      post '/graphql', params: { query: query }
      json_response = Oj.load(response.body, symbol_keys: true)

      user = User.first
      expect(user.username).to eq 'testusername'
    end
  end
end
