require 'rails_helper'

RSpec.describe Mutations::Posts::CreatePost, type: :request do
  set_graphql_type

  describe 'create_post' do
    types = GraphQL::Define::TypeDefiner.instance

    before :each do
      ActiveStorage::Blob.destroy_all
      Post.destroy_all
      User.destroy_all

      @blob1 = ActiveStorage::Blob.create_after_upload! io: file_fixture('test-image1.jpg').open, filename: 'test-image3.jpg', content_type: 'image/jpg', metadata: nil
      @blob2 = ActiveStorage::Blob.create_after_upload! io: file_fixture('test-image2.jpg').open, filename: 'test-image3.jpg', content_type: 'image/jpg', metadata: nil
      @blob3 = ActiveStorage::Blob.create_after_upload! io: file_fixture('test-image3.jpg').open, filename: 'test-image3.jpg', content_type: 'image/jpg', metadata: nil
    end

    it 'creates a new post for the given user' do
      user1 = create(:user, :with_avatar)

      expect do
        post '/graphql', params: { query: query(user_id: user1.id) }
      end.to change{ user1.posts.count }.by(1)
    end

    it 'returns a post type object' do
      user2 = create(:user, :with_avatar)

      post '/graphql', params: { query: query(user_id: user2.id) }

      json = JSON.parse(response.body, symbolize_names: true)
      data = json[:data][:createPost]

      new_post = User.find(user2.id).posts.last
      
      expect(data).to be_a Hash

      images = new_post.images.map do |image|
        rails_blob_url(image, only_path: true)
      end
      user = { id: user2.id.to_s, username: user2.username, avatar: rails_blob_url(user2.avatar, only_path: true) }

      expect(data[:id]).to eq new_post.id.to_s
      expect(data[:title]).to eq new_post.title
      expect(data[:imageUrls].count).to eq new_post.images.count
      expect(data[:upvotes]).to eq new_post.upvotes
      expect(data[:downvotes]).to eq new_post.downvotes
      expect(data[:createdAt]).to be_a String
      expect(data[:updatedAt]).to be_a String
      expect(data[:user]).to eq(user)
    end

    def image_ids
      [@blob1.signed_id, @blob2.signed_id, @blob3.signed_id]
    end

    def query(user_id:)
      <<~GQL
        mutation createPost {
          createPost(input: {
            title: "Help! A swarm!"
            description: "Holy swarmoly, I could use a hand here!"
            imageIds: #{image_ids}
            userId: #{user_id}
            }
          ){ 
            id
            title
            description
            imageUrls
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
