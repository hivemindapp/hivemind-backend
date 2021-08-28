require 'rails helper'

RSpec.describe Types::MutationType, type: :create do
  set_graphql_type

  describe 'comment' do
    it 'creates a new comment' do
      user1 = create(:user)
      user2 = create(:user)

      posts1 = create_list(:post, 5, user: user1)

      post '/graphql', params: { query: query }
      json = JSON.parse(response.body, symbolize_names: true)
    end
  end
end