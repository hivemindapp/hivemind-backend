require 'rails_helper'

RSpec.describe Types::QueryType, type: :request do
  set_graphql_type

  describe 'comments' do
    types = GraphQL::Define::TypeDefiner.instance

    it 'lists all comments for a post' do
      user1 = create(:user)
      user2 = create(:user)
      user3 = create(:user)
      user4 = create(:user)

      posts1 = create(:post, user: user1)

      comment1 = create(:comment, user: user1, post: posts1)
      comment1 = create(:comment, user: user2, post: posts1)
      comment1 = create(:comment, user: user3, post: posts1)

      post '/graphql', params: { query: post_query }

      json = JSON.parse(response.body, symbolize_names: true)

      require 'pry'; binding.pry
    end

    def post_query
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