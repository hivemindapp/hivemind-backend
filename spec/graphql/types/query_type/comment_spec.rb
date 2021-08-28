require 'rails_helper'

RSpec.describe Types::QueryType, type: :request do
  set_graphql_type

  describe 'comments' do
    types = GraphQL::Define::TypeDefiner.instance
    before :each do
      @user1 = create(:user)
      @user2 = create(:user)
      @user3 = create(:user)
      @user4 = create(:user)

      @posts1 = create(:post, user: @user1)

      @comment1 = create(:comment, user: @user1, post: @posts1)
      @comment1 = create(:comment, user: @user2, post: @posts1)
      @comment1 = create(:comment, user: @user3, post: @posts1)
    end

    it 'lists all comments for a post' do
      post '/graphql', params: { query: post_query }

      json = JSON.parse(response.body, symbolize_names: true)

      expect(json[:data][:post][:comments].count).to eq(3)
      expect(json[:data][:post][:comments][0][:content]).to be_a String
    end

    def post_query
      <<~GQL
        query {
          post(id: "#{@posts1.id}") {
            id
            comments {
              content
            }
          }
        }
      GQL
    end
  end
end