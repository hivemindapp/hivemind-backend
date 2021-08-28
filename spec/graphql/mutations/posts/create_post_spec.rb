require 'rails_helper'

RSpec.describe Mutations::Posts::CreatePost, type: :request do
  set_graphql_type

  describe 'create_post' do
    types = GraphQL::Define::TypeDefiner.instance

    it 'creates a new post for the given user' do
      user1 = create(:user)

      expect do
        post '/graphql', params: { query: query(user_id: user1.id) }
      end.to change{ user1.posts.count }.by(1)
    end

    it 'returns a post type object' do
      user2 = create(:user)

      post '/graphql', params: { query: query(user_id: user2.id) }

      json = JSON.parse(response.body, symbolize_names: true)
      data = json[:data][:createPost]

      new_post = User.find(user2.id).posts.last
      
      expect(data).to be_a Hash

      expect(data[:id]).to eq new_post.id.to_s
      expect(data[:title]).to eq new_post.title
      expect(data[:image]).to eq new_post.image
      expect(data[:upvotes]).to eq new_post.upvotes
      expect(data[:downvotes]).to eq new_post.downvotes
      expect(data[:createdAt]).to be_present
      expect(data[:updatedAt]).to be_present
      expect(data[:user]).to eq({ id: user2.id.to_s, username: user2.username, avatar: user2.avatar })
    end

    def query(user_id:)
      <<~GQL
        mutation createPost {
          createPost(input: {
            title: "Help! A swarm!"
            description: "Holy swarmoly, I could use a hand here!"
            image: "https://loremflickr.com/119/211/swarm"
            userId: #{user_id}
            }
          ){ 
            id
            title
            description
            image
            upvotes
            downvotes
            createdAt
            updatedAt
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
