require 'rails_helper'

RSpec.describe Types::QueryType, type: :request do
  set_graphql_type

  describe 'post details' do
    types = GraphQL::Define::TypeDefiner.instance
    before :each do
      @user1 = create(:user)
      @user2 = create(:user)
      @user3 = create(:user)
      @user4 = create(:user)

      @posts1 = create(:post, user: @user1)

      @comment1 = create(:comment, user: @user1, post: @posts1)
      @comment2 = create(:comment, user: @user2, post: @posts1)
      @comment3 = create(:comment, user: @user3, post: @posts1)
    end

    it 'lists all details for a post' do
      post '/graphql', params: { query: post_query }

      json = JSON.parse(response.body, symbolize_names: true)
      data = json[:data][:post]

      expect(data[:id].to_i).to eq(@posts1.id)
      expect(data[:title]).to eq(@posts1.title)
      expect(data[:description]).to eq(@posts1.description)
      expect(data[:image]).to eq(@posts1.image)
      expect(data[:user][:id].to_i).to eq(@user1.id)
      expect(data[:user][:username]).to eq(@user1.username)
      expect(data[:user][:avatar]).to eq(@user1.avatar)
      expect(data[:comments].count).to eq(3)
      expect(data[:comments][1][:content]).to eq(@comment2.content)
      expect(data[:comments][1][:user][:id].to_i).to eq(@user2.id)
      expect(data[:comments][1][:user][:username]).to eq(@user2.username)
      expect(data[:comments][1][:user][:avatar]).to eq(@user2.avatar)
    end

    def post_query
      <<~GQL
        query {
          post(id: "#{@posts1.id}") {
            id
            title
            description
            image
            user {
              id
              username
              avatar
            }
            comments {
              id
              content
              user {
                id
                username
                avatar
              }
            }
          }
        }
      GQL
    end
  end
end